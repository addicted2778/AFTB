import 'package:atfb/components/custom_app_bar.dart';
import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/utils/global.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controller/webview_controller.dart';

class CustomWebView extends StatefulWidget {
  final String url;
  final String appBarTitle;

  CustomWebView({Key? key, required this.url, required this.appBarTitle})
      : super(key: key);

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  WebViewController controller = WebViewController();
  AppWebViewController customController = Get.put(AppWebViewController());

  @override
  void initState() {
    widget.url.logCustom();
    // TODO: implement initState
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            customController.loadingPercentage.value = progress;
            // Update loading bar.
          },
          onPageStarted: (String url) {
            // if (url.contains('http://garansafe.kbdevs.com/success-url')) {
            //   'successUrl'.logCustom();
            // }
            //
            // url.toString().logCustom();

            customController.loadingPercentage.value = 0;
          },
          onPageFinished: (String url) {
            customController.loadingPercentage.value = 100;
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          appbarTitle: widget.appBarTitle.tr,
          isLeading: true,
          onTap: () {
            Get.back();
          },
        ),
        body: Obx(
          () => Container(
            width: w,
            height: h,
            color: Colors.white,
            child: Stack(
              children: [
                WebViewWidget(controller: controller),
                if (customController.loadingPercentage.value < 100)
                  Column(
                    children: [
                      LinearProgressIndicator(
                        value: customController.loadingPercentage.value / 100.0,
                        color: AppColor.primaryColor,
                      )
                    ],
                  )
              ],
            ),
            /*  child: Column(
            children: [
              CustomAppBar(
                appbarTitle: widget.appBarTitle,
                onTap: () {
                  Get.back();
                },
                isLeading: true,
              ),

            ],
          )*/
          ),
        ));
  }
}

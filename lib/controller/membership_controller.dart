import 'package:atfb/export_files/export_files_must.dart';
import 'package:get/get.dart';

class MembershipController extends GetxController {
  getMemberShipDetails() async {
    final response = await API.instance
        .post(endPoint: APIEndPoints.membershipDetail, params: {});
  }
}

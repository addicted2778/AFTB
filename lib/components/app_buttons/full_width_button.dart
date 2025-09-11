import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/styles/app_textstyle.dart';
import 'package:flutter/material.dart';

class FullWidthButton extends StatefulWidget {
  FullWidthButton(
      {super.key,
      required this.buttonText,
      this.buttonTap,
      this.isLoading = false});

  String buttonText;
  Function()? buttonTap;
  bool isLoading;

  @override
  State<FullWidthButton> createState() => _FullWidthButtonState();
}

class _FullWidthButtonState extends State<FullWidthButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.buttonTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: (widget.isLoading)
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                widget.buttonText,
                style: AppTextStyle.semiBoldWhite(fontSize: 18),
              ),
      ),
    );
  }
}

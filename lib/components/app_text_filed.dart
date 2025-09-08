import 'package:atfb/export_files/export_files_must.dart';
import 'package:atfb/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFiled extends StatelessWidget {
  AppTextFiled(
      {super.key,
      this.focusNode,
      this.textFiledKey,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.labelText,
      this.fontsize = 18,
      this.inputFormatter,
      this.color = const Color.fromRGBO(28, 182, 248, 1),
      this.controller,
      this.validator,
      this.suffixIcon,
      this.prefixIcon,
      this.errorText = '',
      this.style,
      this.onChanged,
      this.contentPadding,
      this.onFieldSubmitted,
      this.hintText,
      this.textInputAction,
      this.readOnly = false,
      this.expand = false,
      this.maxlength = 200,
      this.minLines = false,
      this.hintStyle,
      this.isBlueColor = true,
      this.onTap,
      this.suffixIconOnTap,
      this.prefixIconConstraints,
      this.maxlines = 1});

  final bool obscureText;
  final bool isBlueColor;
  final bool readOnly;
  final bool expand;
  final TextInputType keyboardType;
  final int maxlines;
  final String? labelText;
  final String? hintText;
  final double fontsize;
  // final InputBorder enabledBorder;
  final Color color;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? errorText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final int? maxlength;
  final bool minLines;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final BoxConstraints? prefixIconConstraints;
  final List<TextInputFormatter>? inputFormatter;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;
  final Function()? onTap;
  final Function()? suffixIconOnTap;
  final FocusNode? focusNode;
  final GlobalKey<FormFieldState>? textFiledKey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      style: AppTextStyle.mediumCustom(color: Colors.black),
      maxLines: maxlines,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: AppTextStyle.mediumCustom(color: AppColor.primaryColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryColor, width: 1),
        ),
      ),
    );
  }
}

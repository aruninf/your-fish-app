import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourfish/CONTROLLERS/auth_controller.dart';
import '../UTILS/app_color.dart';

class CommonTextField extends StatelessWidget {
  CommonTextField(
      {super.key,
      this.controller,
      required this.hintText,
        this.isReadOnly,
        this.textInputType,
      this.maxLength,
      this.maxLine});

  final TextEditingController? controller;
  final int? maxLine;
  final int? maxLength;
  final bool? isReadOnly;
  final TextInputType? textInputType;
  final String hintText;
  final uController=Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child:TextFormField(
            controller: controller,
            keyboardType: textInputType ?? TextInputType.text,
            textInputAction: TextInputAction.done,
            maxLines: maxLine ?? 1,
            readOnly: isReadOnly ?? false,
            maxLength: maxLength ?? TextField.noMaxLength,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
                isDense: true,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                hintStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                hintText: hintText
            )
        )
    );
  }
}

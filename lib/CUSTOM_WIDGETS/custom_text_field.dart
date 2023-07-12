import 'package:flutter/material.dart';

import '../UTILS/app_color.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      this.controller,
      required this.hintText,
        this.isPassword,
        this.textInputType,
      this.maxLength,
      this.maxLine});

  final TextEditingController? controller;
  final int? maxLine;
  final int? maxLength;
  final bool? isPassword;
  final TextInputType? textInputType;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: TextFormField(
            controller: controller,
            keyboardType: textInputType ?? TextInputType.text,
            obscureText: isPassword ?? false,
            maxLines: maxLine ?? 1,
            maxLength: maxLength ?? TextField.noMaxLength,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            validator: (text) {
              if (text == null || text.isEmpty) {
                return '$hintText required';
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',isDense: true,
                suffixIcon: (isPassword ?? false)
                    ? const Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      )
                    : const SizedBox(),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                hintStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                hintText: hintText)));
  }
}

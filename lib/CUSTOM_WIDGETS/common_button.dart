import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.btnBgColor,
      required this.btnTextColor,
      required this.btnText,
      required this.onClick});

  final Color btnBgColor;
  final Color btnTextColor;
  final String btnText;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: btnBgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        onPressed: onClick,
        child: Text(btnText.toUpperCase(),
            style: TextStyle(
                color: btnTextColor,
                fontWeight: FontWeight.w800,
                fontSize: 18)));
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yourfish/UTILS/app_color.dart';

class BottomComposer extends StatelessWidget {
  const BottomComposer({
    Key? key,
    required this.widget,
    required this.pickFileClick,
    required this.sendClick,
    required this.file,
    this.messageType,
  }) : super(key: key);

  final VoidCallback pickFileClick;
  final VoidCallback sendClick;
  final Widget widget;
  final File file;
  final int? messageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.photo_camera,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: pickFileClick,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                  child: widget,
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              TextButton(
                style:
                    TextButton.styleFrom(backgroundColor: primaryColor,),
                onPressed: sendClick,
                child: const Text(
                  "Send",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                )
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
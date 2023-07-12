import 'package:flutter/material.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/consts.dart';

import 'chat_model.dart';

class ReceiverWidgetItem extends StatelessWidget {
  const ReceiverWidgetItem(
      {Key? key, required this.chatModel, required this.documentReference})
      : super(key: key);
  final ChatResult chatModel;
  final String documentReference;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 300.0,
          child: Wrap(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(1.0),
                      bottomRight: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                      topLeft: Radius.circular(16.0),
                    )),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                margin: const EdgeInsets.only(left: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    chatModel.messageType == 2
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            height: 250,
                            width: double.infinity,
                            image: NetworkImage(
                              chatModel.message ?? '',
                            ),
                            placeholder: const AssetImage(
                                "images/fishing_rod.png"),
                          ),
                        )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chatModel.message ?? '',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    height: 1.2,
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                Consts.parseTimeStamp(
                                    int.parse(chatModel.timeStamp!)),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    height: 1.2,
                                    color: Colors.white70,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

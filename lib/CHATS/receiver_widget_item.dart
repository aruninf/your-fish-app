import 'package:flutter/material.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/consts.dart';

import '../CUSTOM_WIDGETS/image_place_holder_widget.dart';
import '../UTILS/app_images.dart';
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
                decoration: BoxDecoration(
                    border: Border.all(width: 0.56, color: Colors.white),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(8),
                    )),
                padding: const EdgeInsets.symmetric(
                    horizontal: 6.0, vertical: 3.0),
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
                                  fishPlaceHolder),
                              imageErrorBuilder:
                                  (context, error, stackTrace) {
                                return Image.asset(
                                  fishPlaceHolder,
                                  fit: BoxFit.cover,
                                  height: 250,
                                  width: double.infinity,
                                );
                              }
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
                                    color: fishColor,
                                    fontSize: 13,),
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                Consts.parseTimeStamp(
                                    int.parse(chatModel.timeStamp!)).toLowerCase(),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    color: secondaryColor,
                                    fontSize: 12.0,),
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

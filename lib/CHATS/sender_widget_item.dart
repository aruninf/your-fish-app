import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:yourfish/UTILS/app_color.dart';
import 'package:yourfish/UTILS/consts.dart';

import 'chat_model.dart';

class SenderWidgetItem extends StatelessWidget {
  const SenderWidgetItem(
      {Key? key, required this.chatModel, required this.documentReference})
      : super(key: key);
  final ChatResult chatModel;
  final String documentReference;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.97,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 300.0,
            child: Wrap(
              alignment: WrapAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.56, color: Colors.white),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(0),
                      )),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      chatModel.messageType == 2
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: FadeInImage(
                                  fit: BoxFit.cover,
                                  height: 250,
                                  width: double.infinity,
                                  image: NetworkImage(chatModel.message ?? ''),
                                  placeholder: const AssetImage(
                                      "images/fishing_rod.png"),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                      "images/fishing_rod.png",
                                      fit: BoxFit.cover,
                                      height: 250,
                                      width: double.infinity,
                                    );
                                  }),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  chatModel.message ?? '',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: btnColor,
                                      fontSize: 13,),
                                ),
                                const SizedBox(
                                  height: 3.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      Consts.parseTimeStamp(
                                          int.parse(chatModel.timeStamp!)).toLowerCase(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          color: secondaryColor,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(width: 3,),
                                    chatModel.status == "0"
                                            ? const Icon(PhosphorIcons.check,size: 18, color: secondaryColor,)
                                            :  const Icon(PhosphorIcons.checks,size: 18, color: Colors.greenAccent,)
                                  ],
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
      ),
    );
  }
}

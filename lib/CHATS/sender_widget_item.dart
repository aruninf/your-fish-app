import 'package:flutter/material.dart';
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
                      color: Colors.grey.shade100,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16.0),
                        bottomRight: Radius.circular(1.0),
                        topRight: Radius.circular(16.0),
                        topLeft: Radius.circular(16.0),
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
                                      height: 1.2,
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
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
                                          int.parse(chatModel.timeStamp!)),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          height: 1.2,
                                          color: Colors.black45,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    chatModel.isDeleted!
                                        ? Container()
                                        : chatModel.status == "0"
                                            ? const Icon(Icons.check,size: 18,)
                                            : const Icon(
                                                Icons.check,size: 18,
                                                color: Colors.green,
                                              )
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

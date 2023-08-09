
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:yourfish/CHATS/receiver_widget_item.dart';
import 'package:yourfish/CHATS/sender_widget_item.dart';

import 'chat_model.dart';



class ChatItemRow extends StatelessWidget {
  const ChatItemRow({Key? key, required this.userId, required this.documentSnapshot})
      : super(key: key);
  final DocumentSnapshot? documentSnapshot;
  final String userId;

  @override
  Widget build(BuildContext context) {
    if (documentSnapshot != null) {
      ChatResult chatMessages = ChatResult.fromDocument(documentSnapshot!);
      return chatMessages.receiverId != userId
          ? ReceiverWidgetItem(
              chatModel: chatMessages,
              documentReference: documentSnapshot!.reference.path)
          : SenderWidgetItem(
              chatModel: chatMessages,
              documentReference: documentSnapshot!.reference.path,
            );
    } else {
      return Container();
    }
  }
}

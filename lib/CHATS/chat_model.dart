import 'package:cloud_firestore/cloud_firestore.dart';


class ReceiverModel {
  String? receiverId;
  String? matchRoomId;

  ReceiverModel({this.matchRoomId,this.receiverId});

}







class ChatResult {
  String? id;
  String? senderId;
  String? receiverId;
  int? messageType;
  String? message;
  String? timeStamp;
  String? status;
  String? chatroomId;
  String? senderName;
  String? senderProfile;
  bool? isDeleted;

  ChatResult(
      {this.id,
        this.senderId,
        this.receiverId,
        this.messageType,
        this.message,
        this.timeStamp,
        this.status,
        this.chatroomId,
        this.senderName,
        this.senderProfile,
        this.isDeleted});

  ChatResult.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot["id"];
    senderId = documentSnapshot['senderId'];
    receiverId = documentSnapshot['receiverId'];
    messageType = documentSnapshot['messageType'];
    message = documentSnapshot['message'];
    timeStamp = documentSnapshot['timeStamp'];
    status = documentSnapshot['status'];
    chatroomId = documentSnapshot['chatroomId'];
    senderName = documentSnapshot['senderName'];
    senderProfile = documentSnapshot["senderProfile"];
    isDeleted = documentSnapshot['isDeleted'];
  }

  ChatResult.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    messageType = json['messageType'];
    message = json['message'];
    timeStamp = json['timeStamp'];
    status = json['status'];
    chatroomId = json['chatroomId'];
    senderName = json['senderName'];
    senderProfile = json["senderProfile"];
    senderProfile = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['messageType'] = this.messageType;
    data['message'] = this.message;
    data['timeStamp'] = this.timeStamp;
    data['status'] = this.status;
    data['chatroomId'] = this.chatroomId;
    data['senderName'] = this.senderName;
    data['senderProfile'] = this.senderProfile;
    data['isDeleted'] = this.isDeleted;
    return data;
  }

  factory ChatResult.fromDocument(DocumentSnapshot documentSnapshot) {
    ChatResult chatResult = ChatResult();
    chatResult.id = documentSnapshot.get("id");
    chatResult.senderId = documentSnapshot.get("senderId");
    chatResult.receiverId = documentSnapshot.get("receiverId");
    chatResult.messageType = documentSnapshot.get("messageType");
    chatResult.message = documentSnapshot.get("message");
    chatResult.timeStamp = documentSnapshot.get("timeStamp");
    chatResult.status = documentSnapshot.get("status");
    chatResult.chatroomId = documentSnapshot.get("chatroomId");
    chatResult.senderName = documentSnapshot.get("senderName");
    chatResult.senderProfile = documentSnapshot.get("senderProfile");
    chatResult.isDeleted = documentSnapshot.get("isDeleted");
    return chatResult;
  }
}

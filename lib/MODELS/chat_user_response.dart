class ChatUserResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<ChatUserData>? data;

  ChatUserResponse({this.status, this.message, this.statusCode, this.data});

  ChatUserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <ChatUserData>[];
      json['data'].forEach((v) {
        data!.add(new ChatUserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatUserData {
  int? id;
  int? senderId;
  int? receiverId;
  String? matchId;
  int? status;
  String? lastMessage;
  String? dateTime;
  String? createdAt;
  String? updatedAt;
  String? senderName;
  String? receiverName;
  String? receiverProfile;

  ChatUserData(
      {this.id,
        this.senderId,
        this.receiverId,
        this.matchId,
        this.status,
        this.lastMessage,
        this.dateTime,
        this.createdAt,
        this.updatedAt,
        this.senderName,
        this.receiverName,
        this.receiverProfile
      });

  ChatUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    matchId = json['match_id'];
    status = json['status'];
    lastMessage = json['last_message'];
    dateTime = json['date_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    senderName = json['sender_name'];
    receiverName = json['receiver_name'];
    receiverProfile=json['receiver_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['match_id'] = this.matchId;
    data['status'] = this.status;
    data['last_message'] = this.lastMessage;
    data['date_time'] = this.dateTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['sender_name'] = this.senderName;
    data['receiver_name'] = this.receiverName;
    data['receiver_profile'] = this.receiverProfile;
    return data;
  }
}
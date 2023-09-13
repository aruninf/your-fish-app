class SettingResponse {
  bool? status;
  String? message;
  int? statusCode;
  Settings? data;

  SettingResponse({this.status, this.message, this.statusCode, this.data});

  SettingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    data = json['data'] != null ? new Settings.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Settings {
  int? id;
  int? userId;
  String? publicFeed;
  int? newMessage;
  int? newFishUnlocked;
  int? bites100;
  int? comment;
  int? newLocation;
  int? newFollower;
  int? newShareOnPost;
  String? createdAt;
  String? updatedAt;
  String? userName;

  Settings(
      {this.id,
        this.userId,
        this.publicFeed,
        this.newMessage,
        this.newFishUnlocked,
        this.bites100,
        this.comment,
        this.newLocation,
        this.newFollower,
        this.newShareOnPost,
        this.createdAt,
        this.updatedAt,
        this.userName});

  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    publicFeed = json['public_feed'];
    newMessage = json['new_message'];
    newFishUnlocked = json['new_fish_unlocked'];
    bites100 = json['bites_100'];
    comment = json['comment'];
    newLocation = json['new_location'];
    newFollower = json['new_follower'];
    newShareOnPost = json['new_share_on_post'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['public_feed'] = this.publicFeed;
    data['new_message'] = this.newMessage;
    data['new_fish_unlocked'] = this.newFishUnlocked;
    data['bites_100'] = this.bites100;
    data['comment'] = this.comment;
    data['new_location'] = this.newLocation;
    data['new_follower'] = this.newFollower;
    data['new_share_on_post'] = this.newShareOnPost;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_name'] = this.userName;
    return data;
  }
}

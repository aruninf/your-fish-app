class UserResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<UserData>? data;

  UserResponse({this.status, this.message, this.statusCode, this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add( UserData.fromJson(v));
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

class UserData {
  int? id;
  String? userType;
  String? name;
  String? handle;
  String? email;
  String? dob;
  String? gender;
  String? phoneNumber;
  String? profilePic;
  String? gearId;
  int? status;
  String? socialType;
  String? socialId;
  String? createdAt;
  String? updatedAt;
  int? totalPosts;
  int? followingStatus;

  UserData(
      {this.id,
        this.userType,
        this.name,
        this.handle,
        this.email,
        this.dob,
        this.gender,
        this.phoneNumber,
        this.profilePic,
        this.gearId,
        this.status,
        this.socialType,
        this.socialId,
        this.createdAt,
        this.updatedAt,
        this.totalPosts,
        this.followingStatus
      });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    name = json['name'];
    handle = json['handle'];
    email = json['email'];
    dob = json['dob'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    profilePic = json['profile_pic'];
    gearId = json['gear_id'];
    status = json['status'];
    socialType = json['social_type'];
    socialId = json['social_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalPosts = json['total_posts'];
    followingStatus = json['following_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_type'] = this.userType;
    data['name'] = this.name;
    data['handle'] = this.handle;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['phone_number'] = this.phoneNumber;
    data['profile_pic'] = this.profilePic;
    data['gear_id'] = this.gearId;
    data['status'] = this.status;
    data['social_type'] = this.socialType;
    data['social_id'] = this.socialId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['total_posts'] = this.totalPosts;
    data['following_status'] = this.followingStatus;
    return data;
  }
}
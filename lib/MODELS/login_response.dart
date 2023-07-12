class LoginResponse {
  bool? status;
  String? message;
  int? statusCode;
  LoginData? data;
  String? token;

  LoginResponse(
      {this.status, this.message, this.statusCode, this.data, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    data = json['data'] != null ?  LoginData.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class LoginData {
  int? id;
  String? userType;
  String? name;
  String? handle;
  String? email;
  String? dob;
  String? gender;
  String? phoneNumber;
  String? profilePic;
  String? locationId;
  String? interestedFishId;
  String? experienceFishId;
  String? fishCatId;
  String? gearId;
  int? status;
  String? createdAt;
  String? updatedAt;

  LoginData(
      {this.id,
        this.userType,
        this.name,
        this.handle,
        this.email,
        this.dob,
        this.gender,
        this.phoneNumber,
        this.profilePic,
        this.locationId,
        this.interestedFishId,
        this.experienceFishId,
        this.fishCatId,
        this.gearId,
        this.status,
        this.createdAt,
        this.updatedAt});

  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    name = json['name'];
    handle = json['handle'];
    email = json['email'];
    dob = json['dob'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    profilePic = json['profile_pic'];
    locationId = json['location_id'];
    interestedFishId = json['interested_fish_id'];
    experienceFishId = json['experience_fish_id'];
    fishCatId = json['fish_cat_id'];
    gearId = json['gear_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['location_id'] = this.locationId;
    data['interested_fish_id'] = this.interestedFishId;
    data['experience_fish_id'] = this.experienceFishId;
    data['fish_cat_id'] = this.fishCatId;
    data['gear_id'] = this.gearId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
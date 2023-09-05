class SavedPostResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<SavedPost>? data;

  SavedPostResponse({this.status, this.message, this.statusCode, this.data});

  SavedPostResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <SavedPost>[];
      json['data'].forEach((v) {
        data!.add(new SavedPost.fromJson(v));
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

class SavedPost {
  int? id;
  String? requestType;
  int? userId;
  int? postId;
  int? requestStatus;
  String? createdAt;
  String? updatedAt;
  String? locationId;
  int? isPublic;
  String? latitude;
  String? longitude;
  String? address;
  String? tagFish;
  String? image;
  String? caption;
  int? status;
  int? pId;
  int? pUId;

  SavedPost(
      {this.id,
        this.requestType,
        this.userId,
        this.postId,
        this.requestStatus,
        this.createdAt,
        this.updatedAt,
        this.locationId,
        this.isPublic,
        this.latitude,
        this.longitude,
        this.address,
        this.tagFish,
        this.image,
        this.caption,
        this.status,
        this.pId,
        this.pUId});

  SavedPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestType = json['request_type'];
    userId = json['user_id'];
    postId = json['post_id'];
    requestStatus = json['request_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    locationId = json['location_id'];
    isPublic = json['isPublic'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    tagFish = json['tag_fish'];
    image = json['image'];
    caption = json['caption'];
    status = json['status'];
    pId = json['p_id'];
    pUId = json['p_u_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['request_type'] = this.requestType;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['request_status'] = this.requestStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['location_id'] = this.locationId;
    data['isPublic'] = this.isPublic;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['tag_fish'] = this.tagFish;
    data['image'] = this.image;
    data['caption'] = this.caption;
    data['status'] = this.status;
    data['p_id'] = this.pId;
    data['p_u_id'] = this.pUId;
    return data;
  }
}
class PostResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<PostData>? data;

  PostResponse({this.status, this.message, this.statusCode, this.data});

  PostResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <PostData>[];
      json['data'].forEach((v) {
        data!.add(new PostData.fromJson(v));
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

class PostData {
  int? id;
  int? userId;
  int? isPublic;
  int? type;
  String? latitude;
  String? longitude;
  String? address;
  String? image;
  String? caption;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? userName;
  String? userHandle;
  List<TagFish>? tagFish;
  bool? isLiked;
  bool? isFavourite;
  int? totalLikes;

  PostData(
      {this.id,
        this.userId,
        this.isPublic,
        this.type,
        this.latitude,
        this.longitude,
        this.address,
        this.tagFish,
        this.image,
        this.caption,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.userName,
        this.userHandle,
        this.isLiked,
        this.isFavourite,
        this.totalLikes
      });

  PostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    isPublic = json['isPublic'];
    type = json['type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    if (json['tag_fish'] != null) {
      tagFish = <TagFish>[];
      json['tag_fish'].forEach((v) {
        tagFish!.add(new TagFish.fromJson(v));
      });
    }
    image = json['image'];
    caption = json['caption'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userName = json['user_name'];
    userHandle = json['user_handle'];
    isLiked = json['isLiked'];
    isFavourite = json['isfavourite'];
    totalLikes = json['total_likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['isPublic'] = isPublic;
    data['type'] = type;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    if (tagFish != null) {
      data['tag_fish'] = tagFish!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['caption'] = this.caption;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_name'] = this.userName;
    data['user_handle'] = this.userHandle;

    data['isLiked'] = this.isLiked;
    data['isfavourite'] = this.isFavourite;
    data['total_likes'] = this.totalLikes;
    return data;
  }
}

class TagFish {
  int? id;
  String? localName;
  String? scientificName;

  TagFish({this.id, this.localName, this.scientificName});

  TagFish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    localName = json['local_name'];
    scientificName = json['scientific_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['local_name'] = this.localName;
    data['scientific_name'] = this.scientificName;
    return data;
  }
}
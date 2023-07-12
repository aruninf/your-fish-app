class FishResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<FishData>? data;

  FishResponse({this.status, this.message, this.statusCode, this.data});

  FishResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <FishData>[];
      json['data'].forEach((v) {
        data!.add(new FishData.fromJson(v));
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

class FishData {
  int? id;
  int? catId;
  String? fishName;
  String? fishImage;
  int? status;
  String? createdAt;
  String? updatedAt;

  FishData(
      {this.id,
        this.catId,
        this.fishName,
        this.fishImage,
        this.status,
        this.createdAt,
        this.updatedAt});

  FishData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    fishName = json['fish_name'];
    fishImage = json['fish_image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['fish_name'] = this.fishName;
    data['fish_image'] = this.fishImage;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
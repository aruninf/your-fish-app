class GearResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<GearData>? data;

  GearResponse({this.status, this.message, this.statusCode, this.data});

  GearResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <GearData>[];
      json['data'].forEach((v) {
        data!.add(new GearData.fromJson(v));
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

class GearData {
  int? id;
  String? userId;
  String? title;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;

  GearData(
      {this.id,
        this.userId,
        this.title,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  GearData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
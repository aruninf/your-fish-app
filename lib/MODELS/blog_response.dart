class BlogResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<BlogData>? data;

  BlogResponse({this.status, this.message, this.statusCode, this.data});

  BlogResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <BlogData>[];
      json['data'].forEach((v) {
        data!.add(new BlogData.fromJson(v));
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

class BlogData {
  int? id;
  String? heading;
  String? subHeading;
  String? image;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;

  BlogData(
      {this.id,
        this.heading,
        this.subHeading,
        this.image,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  BlogData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    heading = json['heading'];
    subHeading = json['sub_heading'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['heading'] = this.heading;
    data['sub_heading'] = this.subHeading;
    data['image'] = this.image;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
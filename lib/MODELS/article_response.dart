class ArticleResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<ArticleData>? data;

  ArticleResponse({this.status, this.message, this.statusCode, this.data});

  ArticleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <ArticleData>[];
      json['data'].forEach((v) {
        data!.add(new ArticleData.fromJson(v));
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

class ArticleData {
  int? id;
  String? title;
  int? category;
  String? article;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? categoryName;

  ArticleData(
      {this.id,
        this.title,
        this.category,
        this.article,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.categoryName});

  ArticleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    article = json['article'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category'] = this.category;
    data['article'] = this.article;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_name'] = this.categoryName;
    return data;
  }
}
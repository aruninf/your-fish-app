class CommentResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<Comments>? data;

  CommentResponse({this.status, this.message, this.statusCode, this.data});

  CommentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <Comments>[];
      json['data'].forEach((v) {
        data!.add(new Comments.fromJson(v));
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

class Comments {
  int? id;
  int? userId;
  int? postId;
  String? comment;
  String? username;
  int? status;
  String? createdAt;
  String? updatedAt;

  Comments(
      {this.id,
        this.userId,
        this.postId,
        this.comment,
        this.username,
        this.status,
        this.createdAt,
        this.updatedAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    comment = json['comment'];
    username =json['user_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['comment'] = this.comment;
    data['user_name'] =this.username;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

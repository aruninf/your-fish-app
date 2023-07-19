class LocationResponse {
  bool? status;
  String? message;
  int? statusCode;
  List<FishingLocationData>? data;

  LocationResponse({this.status, this.message, this.statusCode, this.data});

  LocationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <FishingLocationData>[];
      json['data'].forEach((v) {
        data!.add(new FishingLocationData.fromJson(v));
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

class FishingLocationData {
  int? id;
  String? name;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  FishingLocationData(
      {this.id,
        this.name,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt});

  FishingLocationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
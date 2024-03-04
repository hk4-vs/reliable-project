class UploadImageModel {
  String? originalname;
  String? filename;
  String? location;

  UploadImageModel({this.originalname, this.filename, this.location});

  UploadImageModel.fromJson(Map<String, dynamic> json) {
    originalname = json['originalname'];
    filename = json['filename'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['originalname'] = originalname;
    data['filename'] = filename;
    data['location'] = location;
    return data;
  }
}

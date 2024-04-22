class CountryModel {
  int? id;
  String? name;
  String? code;
  String? telCode;
  String? flag;
  String? createdAt;
  String? updatedAt;

  CountryModel(
      {this.id,
        this.name,
        this.code,
        this.telCode,

        this.flag,
        this.createdAt,
        this.updatedAt});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    telCode = json['tel_code'];

    flag = json['flag'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['tel_code'] = this.telCode;
    data['flag'] = this.flag;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
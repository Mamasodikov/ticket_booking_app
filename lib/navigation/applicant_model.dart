class ApplicantModel {
  ApplicantModel({
      this.objChange, 
      this.socialStatusId, 
      this.id, 
      this.firstName, 
      this.lastName, 
      this.middleName, 
      this.role, 
      this.phone, 
      this.seriesPassport, 
      this.numberPassport, 
      this.birthDate, 
      this.password, 
      this.height, 
      this.weight, 
      this.email, 
      this.imagePassport, 
      this.photo, 
      this.object, 
      this.region, 
      this.streetElder, 
      this.createdAt, 
      this.updatedAt, 
      this.address, 
      this.applicantTypeId, 
      this.gender, 
      this.oneId, 
      this.pin,});

  ApplicantModel.fromJson(dynamic json) {
    objChange = json['objChange'];
    socialStatusId = json['socialStatusId'];
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    role = json['role'];
    phone = json['phone'];
    seriesPassport = json['seriesPassport'];
    numberPassport = json['numberPassport'];
    birthDate = json['birthDate'];
    password = json['password'];
    height = json['height'];
    weight = json['weight'];
    email = json['email'];
    imagePassport = json['imagePassport'];
    photo = json['photo'];
    object = json['object'] != null ? Object.fromJson(json['object']) : null;
    region = json['region'] != null ? Region.fromJson(json['region']) : null;
    streetElder = json['streetElder'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    address = json['address'];
    applicantTypeId = json['applicantTypeId'];
    gender = json['gender'];
    oneId = json['oneId'];
    pin = json['pin'];
  }
  String? objChange;
  int? socialStatusId;
  String? id;
  String? firstName;
  String? lastName;
  String? middleName;
  String? role;
  String? phone;
  String? seriesPassport;
  int? numberPassport;
  String? birthDate;
  String? password;
  int? height;
  int? weight;
  String? email;
  dynamic imagePassport;
  String? photo;
  Object? object;
  Region? region;
  bool? streetElder;
  String? createdAt;
  String? updatedAt;
  String? address;
  String? applicantTypeId;
  int? gender;
  bool? oneId;
  String? pin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objChange'] = objChange;
    map['socialStatusId'] = socialStatusId;
    map['_id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['middleName'] = middleName;
    map['role'] = role;
    map['phone'] = phone;
    map['seriesPassport'] = seriesPassport;
    map['numberPassport'] = numberPassport;
    map['birthDate'] = birthDate;
    map['password'] = password;
    map['height'] = height;
    map['weight'] = weight;
    map['email'] = email;
    map['imagePassport'] = imagePassport;
    map['photo'] = photo;
    if (object != null) {
      map['object'] = object?.toJson();
    }
    if (region != null) {
      map['region'] = region?.toJson();
    }
    map['streetElder'] = streetElder;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['address'] = address;
    map['applicantTypeId'] = applicantTypeId;
    map['gender'] = gender;
    map['oneId'] = oneId;
    map['pin'] = pin;
    return map;
  }

}

class Region {
  Region({
      this.eAppRegionsId, 
      this.oneIdRegionId, 
      this.regionIdOne, 
      this.regionIdEapp, 
      this.id, 
      this.title,});

  Region.fromJson(dynamic json) {
    eAppRegionsId = json['eAppRegionsId'];
    oneIdRegionId = json['oneIdRegionId'];
    regionIdOne = json['regionIdOne'];
    regionIdEapp = json['regionIdEapp'];
    id = json['_id'];
    title = json['title'];
  }
  int? eAppRegionsId;
  String? oneIdRegionId;
  String? regionIdOne;
  int? regionIdEapp;
  String? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eAppRegionsId'] = eAppRegionsId;
    map['oneIdRegionId'] = oneIdRegionId;
    map['regionIdOne'] = regionIdOne;
    map['regionIdEapp'] = regionIdEapp;
    map['_id'] = id;
    map['title'] = title;
    return map;
  }

}

class Object {
  Object({
      this.eAppRegionsId, 
      this.oneIdRegionId, 
      this.regionIdOne, 
      this.regionIdEapp, 
      this.id, 
      this.title,});

  Object.fromJson(dynamic json) {
    eAppRegionsId = json['eApp'];
    oneIdRegionId = json['oneIdRegionId'];
    regionIdOne = json['regionIdOne'];
    regionIdEapp = json['regionIdEapp'];
    id = json['_id'];
    title = json['title'];
  }
  int? eAppRegionsId;
  int? oneIdRegionId;
  String? regionIdOne;
  int? regionIdEapp;
  String? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eApp'] = eAppRegionsId;
    map['oneIdRegionId'] = oneIdRegionId;
    map['regionIdOne'] = regionIdOne;
    map['regionIdEapp'] = regionIdEapp;
    map['_id'] = id;
    map['title'] = title;
    return map;
  }

}
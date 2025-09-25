class TimeTableDetailModel {
  int? statusCode;
  Data? data;
  String? message;

  TimeTableDetailModel({this.statusCode, this.data, this.message});

  TimeTableDetailModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  TimeTableDetail? timeTableDetail;

  Data({this.timeTableDetail});

  Data.fromJson(Map<String, dynamic> json) {
    timeTableDetail = json['time_table_detail'] != null
        ? new TimeTableDetail.fromJson(json['time_table_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timeTableDetail != null) {
      data['time_table_detail'] = this.timeTableDetail!.toJson();
    }
    return data;
  }
}

class TimeTableDetail {
  int? id;
  String? type;
  int? referenceId;
  String? date;
  String? startTime;
  String? endTime;
  GroupSession? groupSession;
  Activity? activity;

  TimeTableDetail(
      {this.id,
      this.type,
      this.referenceId,
      this.date,
      this.startTime,
      this.endTime,
      this.groupSession});

  TimeTableDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    referenceId = json['reference_id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    groupSession = json['group_session'] != null
        ? new GroupSession.fromJson(json['group_session'])
        : null;
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['reference_id'] = this.referenceId;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    if (this.groupSession != null) {
      data['group_session'] = this.groupSession!.toJson();
    }
    if (this.activity != null) {
      data['activity'] = this.activity!.toJson();
    }
    return data;
  }
}

class GroupSession {
  int? id;
  String? colorCode;
  String? name;
  String? description;
  String? location;
  String? startTime;
  String? endTime;
  List<Members>? members;

  GroupSession(
      {this.id,
      this.colorCode,
      this.name,
      this.description,
      this.location,
      this.startTime,
      this.endTime,
      this.members});

  GroupSession.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    colorCode = json['color_code'] ?? 'ffffff';
    name = json['name'] ?? '';
    description = json['description'] ?? '';
    location = json['location'] ?? '';
    startTime = json['start_time'] ?? '';
    endTime = json['end_time'] ?? '';
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color_code'] = this.colorCode;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location'] = this.location;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? patientId;
  String? profilePhoto;
  String? phoneNumber;
  String? emergencyPhoneNumber;
  String? dateOfBirth;
  String? address;
  Null? isPresent;

  Members(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.patientId,
      this.profilePhoto,
      this.phoneNumber,
      this.emergencyPhoneNumber,
      this.dateOfBirth,
      this.address,
      this.isPresent});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    patientId = json['patient_id'];
    profilePhoto = json['profile_photo'];
    phoneNumber = json['phone_number'];
    emergencyPhoneNumber = json['emergency_phone_number'];
    dateOfBirth = json['date_of_birth'];
    address = json['address'];
    isPresent = json['is_present'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['patient_id'] = this.patientId;
    data['profile_photo'] = this.profilePhoto;
    data['phone_number'] = this.phoneNumber;
    data['emergency_phone_number'] = this.emergencyPhoneNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['is_present'] = this.isPresent;
    return data;
  }
}

class Activity {
  int? id;
  String? colorCode;
  String? name;
  String? description;
  String? startTime;
  String? endTime;

  Activity(
      {this.id,
      this.colorCode,
      this.name,
      this.description,
      this.startTime,
      this.endTime});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    colorCode = json['color_code'];
    name = json['name'];
    description = json['description'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color_code'] = this.colorCode;
    data['name'] = this.name;
    data['description'] = this.description;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}

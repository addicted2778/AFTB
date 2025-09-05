class DashboardModel {
  int? statusCode;
  Data? data;
  String? message;

  DashboardModel({this.statusCode, this.data, this.message});

  DashboardModel.fromJson(Map<String, dynamic> json) {
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
  List<Timetable>? timetable;

  Data({this.timetable});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['timetable'] != null) {
      timetable = <Timetable>[];
      json['timetable'].forEach((v) {
        timetable!.add(new Timetable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timetable != null) {
      data['timetable'] = this.timetable!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timetable {
  String? date;
  List<PerTimeTable>? data;

  Timetable({this.date, this.data});

  Timetable.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['data'] != null) {
      data = <PerTimeTable>[];
      json['data'].forEach((v) {
        data!.add(new PerTimeTable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PerTimeTable {
  int? id;
  int? userId;
  String? type;
  int? referenceId;
  String? date;
  String? startTime;
  String? endTime;
  Activity? activity;

  PerTimeTable(
      {this.id,
      this.userId,
      this.type,
      this.referenceId,
      this.date,
      this.startTime,
      this.endTime,
      this.activity});

  PerTimeTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    referenceId = json['reference_id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    activity = json['activity_group_session'] != null
        ? Activity.fromJson(json['activity_group_session'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['reference_id'] = this.referenceId;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    if (this.activity != null) {
      data['activity_group_session'] = this.activity!.toJson();
    }
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

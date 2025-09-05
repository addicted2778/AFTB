class SiteSettingModel {
  int? statusCode;
  SiteSettingData? data;
  String? message;

  SiteSettingModel({this.statusCode, this.data, this.message});

  SiteSettingModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null
        ? new SiteSettingData.fromJson(json['data'])
        : null;
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

class SiteSettingData {
  String? termsAndCondition;
  String? privacyPolicy;
  String? impressum;
  Profile? profile;
  int? updateAndroid;
  int? updateIos;
  String? updateLinkAndroid;
  String? updateLinkIos;
  String? updateMessage;
  int? isCancelShow;
  bool? activeMembership;
  String? membershipEndDate;
  String? membershipDaysLeft;

  SiteSettingData(
      {this.termsAndCondition,
      this.privacyPolicy,
      this.impressum,
      this.profile,
      this.updateAndroid,
      this.updateIos,
      this.updateLinkAndroid,
      this.updateLinkIos,
      this.updateMessage,
      this.isCancelShow,
      this.activeMembership,
      this.membershipEndDate,
      this.membershipDaysLeft});

  SiteSettingData.fromJson(Map<String, dynamic> json) {
    termsAndCondition = json['terms_and_condition'];
    privacyPolicy = json['privacy_policy'];
    impressum = json['impressum'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    updateAndroid = json['update_android'];
    updateIos = json['update_ios'];
    updateLinkAndroid = json['update_link_android'];
    updateLinkIos = json['update_link_ios'];
    updateMessage = json['update_message'];
    isCancelShow = json['is_cancel_show'];
    activeMembership = json['active_membership'];
    membershipEndDate = json['membership_end_date'];
    membershipDaysLeft = json['membership_days_left'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['terms_and_condition'] = this.termsAndCondition;
    data['privacy_policy'] = this.privacyPolicy;
    data['impressum'] = this.impressum;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['update_android'] = this.updateAndroid;
    data['update_ios'] = this.updateIos;
    data['update_link_android'] = this.updateLinkAndroid;
    data['update_link_ios'] = this.updateLinkIos;
    data['update_message'] = this.updateMessage;
    data['is_cancel_show'] = this.isCancelShow;
    data['active_membership'] = this.activeMembership;
    data['membership_end_date'] = this.membershipEndDate;
    data['membership_days_left'] = this.membershipDaysLeft;
    return data;
  }
}

class Profile {
  int? id;
  String? patientId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? emergencyPhoneNumber;
  String? dateOfBirth;
  String? address;
  String? profilePhoto;

  Profile(
      {this.id,
      this.patientId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.emergencyPhoneNumber,
      this.dateOfBirth,
      this.address,
      this.profilePhoto});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patient_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    emergencyPhoneNumber = json['emergency_phone_number'];
    dateOfBirth = json['date_of_birth'];
    address = json['address'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['emergency_phone_number'] = this.emergencyPhoneNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}

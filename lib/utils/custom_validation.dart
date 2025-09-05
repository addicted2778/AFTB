abstract class CustomValidations {
  static validateMobile(String value) {
    final patttern = RegExp(r'(^[6-9][0-9]*$)');
    if (value == '') {
      return "This field can't be empty";
    } else if (value.length != 10) {
      return 'Mobile number must 10 digits';
    } else if (!patttern.hasMatch(value)) {
      return 'Please enter valid Mobile Number';
    }
  }

  static validateString(String value) {
    if (value == '' || value.trim() == '') {
      return "This field can't be empty";
    }
  }

  static validateOtp(String value) {
    final patttern = RegExp(r'(^[6-9][0-9]*$)');
    if (value == '') {
      return "This field can't be empty";
    } else if (value.length != 4) {
      return 'Otp must have 4 digits';
    }
  }

  static validatePincode(String value) {
    final patttern = RegExp(r'(^[6-9][0-9]*$)');
    if (value == '') {
      return "This field can't be empty";
    } else if (value.length != 6) {
      return 'Pincode must have 6 digits';
    }
  }

  static validateEmail(String value) {
    final patttern = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+");
    if (value == '') {
      return "This field can't be empty";
    } else if (!patttern.hasMatch(value)) {
      return 'Please enter valid email address';
    }
  }

  static validateNotificationSetting(String value, int intValue) {
    if (intValue == 0) {
      return null;
    } else {
      if (value == '') {
        return "This field can't be empty";
      } else if (int.parse(value) == 0) {
        return "Days can't be less then 0";
      } else {
        return null;
      }
    }
  }

  static RegExp patttern = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+");

  static validEmailPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter email or phone number';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{3,}$');
    final phoneRegex = RegExp(r'^[6-9]\d{9}$');

    if (emailRegex.hasMatch(value) || phoneRegex.hasMatch(value)) {
      return null; // Valid
    }

    return 'Enter a valid email or 10-digit phone number';
  }
}

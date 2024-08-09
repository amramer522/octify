import 'package:flutter/material.dart';

class InputValidator {
  static final _emailReg =
      RegExp(r'[a-z]+\d*@[a-z]+\.[a-z]{3}', caseSensitive: false);
  static final arabicPhoneNumbersReg = RegExp(r"[\u0661-\u0669]");
  static final _arabicTextReg = RegExp(r"[\u0600-\u06ff]+");
  static final _cardNumbersReg = RegExp(r"\d.{4}");
  static final _saudiNumberReg = RegExp(r"((\+|00)?966|0)?5\d{8}$");
  static final _strongPasswordReg = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");

  static String? validatePhone(String? value) {
    if (value!.isEmpty) {
      return "Phone Must Be Not Empty";
    } else if (!_saudiNumberReg.hasMatch(value)) {
      return "Invalid Phone Number";
    }
    return null;
  }

  static String? emailValidator(String value) {
    if (value.isEmpty) {
      return "Email Required";
    } else if (_emailReg.hasMatch(value)) {
      return null;
    } else {
      return "Invalid Email";
    }
  }

  static String? requiredValidator(
      {required String value,
      required String itemName,
      bool lengthRequired = false,
      int lengthNumber = 3}) {
    if (value.trim().isEmpty) {
      return 'LocaleKeys.validateRequired.tr(namedArgs: {"name": itemName})';
    } else if (value.trim().length < lengthNumber && lengthRequired) {
      return 'LocaleKeys.validateAtLeastDigits.tr(namedArgs: {"name": itemName, "number": lengthNumber.toString()})';
    }
    return null;
  }

  // static String? codeValidator(String value) {
  //   if (value.isEmpty) {
  //     return LocaleKeys.validateRequired.tr(namedArgs: {"name": LocaleKeys.code.tr()});
  //   } else if (value.length < 4) {
  //     return LocaleKeys.validateAtLeast3Digits.tr(namedArgs: {
  //       "name": LocaleKeys.code.tr(),
  //       "number": "4",
  //     });
  //   }
  //   return null;
  // }
  static String? passwordLoginValidator(String value) {
    if (value.isEmpty) {
      return "Password Required";
    }
    if (value.length >= 8) {
      return null;
    } else {
      return "At least 8 digits";
    }
  }

  static String? passwordValidator(
      String value, TextEditingController confirmPassword,
      {lengthRequired = false}) {
    if (value.isEmpty) {
      return "Password Required";
    } else if (lengthRequired) {
      if (value.length >= 8) {
        return null;
      } else {
        return "At least 8 digits";
      }
    } else if (value != confirmPassword.text) {
      return "Passwords Not Matched";
    } else {
      return null;
    }
  }

  //
  static String? confirmPasswordValidator(
      String password, TextEditingController confirmPassword) {
    if (password.isEmpty) {
      return "Confirm Password Required";
    } else if (confirmPassword.text.isEmpty) {
      return null;
    } else if (password != confirmPassword.text) {
      return "Passwords Not Matched";
    }
    return null;
  }

  static bool isNumbersArabic(String value) {
    if (arabicPhoneNumbersReg.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static String replaceArabicNumbers(String value) {
    return value.replaceAllMapped(
        arabicPhoneNumbersReg, (m) => '${(m[0]!.codeUnits[0] - 1584) - 48}');
  }

  static bool isTextArabic(String value) {
    if (_arabicTextReg.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static String showAsCardNumber(String value) {
    return value.replaceAllMapped(_cardNumbersReg, (m) => '${m[0]} ');
  }

  static String fixPhone({required String phone, required String countryCode}) {
    if (phone.trim().startsWith("0")) {
      phone = phone.trim().substring(1);
    }
    return (countryCode) + replaceArabicNumbers(phone);
  }

  static String fixPhoneCode(String phoneCode) {
    if (phoneCode.startsWith("+")) {
      phoneCode = phoneCode.substring(1);
    }
    return phoneCode;
  }
}

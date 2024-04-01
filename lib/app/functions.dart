import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import '../presentation/resources/strings_manager.dart';

bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}


  bool isFieldValid(String text) {
    return text.length >= 5;
  }


  convertImageFileToString(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
  
  convertStringToUint8List(String imageString) {
  Uint8List bytesImage = Base64Decoder().convert(imageString);
  return bytesImage;
}

 String? validateEmail( String? email) {
    if (email != null) {
      if (isEmailValid(email)) {
        return null;
      } else {
        return AppStrings.emailError;
      }
    } else {
      return AppStrings.thisFieldIsRequired;
    }
  }

  String? validatePassword(password) {
    if (password != null) {
      if (password.length >= 6) {
        return null;
      } else {
        return AppStrings.passwordError;
      }
    } else {
      return AppStrings.thisFieldIsRequired;
    }
    
  }
  String? validateUserName(userName) {
    if (userName != null) {
      if (userName.length >= 8) {
        return null;
      } else {
        return AppStrings.userNameError;
      }
    } else {
      return AppStrings.thisFieldIsRequired;
    }
    
  }

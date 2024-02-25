import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String email, String password) = _LoginObject;
}

@freezed
class SignupObject with _$SignupObject {
  factory SignupObject(
  String userName,
 
  String email,
  String password,
 ) = _SignupObject;
}


import 'dart:io';
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

@freezed
class AddNoteWithImageObject with _$AddNoteWithImageObject {
  factory AddNoteWithImageObject(String title, String content, File? image) =
      _AddNoteWithImageObject;
}
@freezed
class AddNoteWithoutImageObject with _$AddNoteWithoutImageObject {
  factory AddNoteWithoutImageObject(String title, String content) =
      _AddNoteWithoutImageObject;
}

@freezed
class EditNoteObject with _$EditNoteObject {
  factory EditNoteObject(int id, String title, String content, File image) =
      _EditNoteObject;
}

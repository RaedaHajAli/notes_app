// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'username')
  String username;
  @JsonKey(name: 'email')
  String email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class Authentication {
  User? data;
  Authentication({
    required this.data,
  });
}

class OperationStatus {
  int status;

  String message;
  OperationStatus({
    required this.status,
    required this.message,
  });
}

class Note {
  int id;
  String title;
  String content;
  String image;
  int userId;
  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.userId,
  });
}

class GetNotes {
  List<Note> notes;
  GetNotes({
    required this.notes,
  });
}

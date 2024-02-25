// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
}

@JsonSerializable()
class UserResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'email')
  String? email;

  UserResponse({
    this.id,
    this.username,
    this.email,
  });
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: 'data')
  UserResponse? data;
  AuthenticationResponse({
    this.data,
  });
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class OperationStatusResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
  OperationStatusResponse({
    this.status,
    this.message,
  });
  factory OperationStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$OperationStatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OperationStatusResponseToJson(this);
}

@JsonSerializable()
class NoteResponse {
  @JsonKey(name: 'note_id')
  int? id;
  @JsonKey(name: 'note_title')
  String? title;
  @JsonKey(name: 'note_content')
  String? content;
  @JsonKey(name: 'note_image')
  String? image;
  @JsonKey(name: 'note_user')
  int? userId;
  NoteResponse({
    this.id,
    this.title,
    this.content,
    this.image,
    this.userId,
  });
  factory NoteResponse.fromJson(Map<String, dynamic> json) =>
      _$NoteResponseFromJson(json);
Map<String, dynamic> toJson() => _$NoteResponseToJson(this);
}

@JsonSerializable()
class GetNotesResponse extends BaseResponse {
  @JsonKey(name: 'notes')
  List<NoteResponse>? notes;
  GetNotesResponse({
    required this.notes,
  });
  factory GetNotesResponse.fromJson(Map<String, dynamic> json) =>_$GetNotesResponseFromJson(json);
Map<String, dynamic> toJson() =>_$GetNotesResponseToJson(this);
}

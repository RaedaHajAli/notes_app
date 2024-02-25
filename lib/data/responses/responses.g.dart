// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['status'] as int?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      data: json['data'] == null
          ? null
          : UserResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

OperationStatusResponse _$OperationStatusResponseFromJson(
        Map<String, dynamic> json) =>
    OperationStatusResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$OperationStatusResponseToJson(
        OperationStatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

NoteResponse _$NoteResponseFromJson(Map<String, dynamic> json) => NoteResponse(
      id: json['note_id'] as int?,
      title: json['note_title'] as String?,
      content: json['note_content'] as String?,
      image: json['note_image'] as String?,
      userId: json['note_user'] as int?,
    );

Map<String, dynamic> _$NoteResponseToJson(NoteResponse instance) =>
    <String, dynamic>{
      'note_id': instance.id,
      'note_title': instance.title,
      'note_content': instance.content,
      'note_image': instance.image,
      'note_user': instance.userId,
    };

GetNotesResponse _$GetNotesResponseFromJson(Map<String, dynamic> json) =>
    GetNotesResponse(
      notes: (json['notes'] as List<dynamic>?)
          ?.map((e) => NoteResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetNotesResponseToJson(GetNotesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'notes': instance.notes,
    };

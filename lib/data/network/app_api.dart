import 'package:dio/dio.dart';

import 'dart:io';

import 'package:retrofit/retrofit.dart';

import '../../app/constants.dart';
import '../responses/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  //auth

  @POST('auth/signup.php')
  Future<AuthenticationResponse> signup(@Field('username') String username,
      @Field('email') String email, @Field('password') String password);

  @POST('auth/login.php')
  Future<AuthenticationResponse> login(
      @Field('email') String email, @Field('password') String password);

  //notes

  @POST('notes/add.php')
  @MultiPart()
  Future<OperationStatusResponse> add(
    @Part() String title,
    @Part() String content,
    @Part(name: 'user_id') int userId, {
    @Part() File? image,
  });

//Delete
  @POST('notes/delete.php')
  @MultiPart()
  Future<OperationStatusResponse> delete(@Part(name: 'note_id') int noteId,
      @Part(name: 'image_name') String imageName);

  //Edit
  @POST('notes/edit.php')
  @MultiPart()
  Future<OperationStatusResponse> edit(
    @Part(name: 'note_id') int noteId,
    @Part(name: 'title') String title,
    @Part(name: 'content') String content,
     @Part(name: 'image_name') String imageName,
     {
    @Part(name: 'new_image') File? newImage,
  });
  @GET('notes/view.php')
  Future<GetNotesResponse> view(
    @Field('user_id') int userId,
  );
}

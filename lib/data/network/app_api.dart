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

  @POST('notes/addwithimage.php')
  @MultiPart()
  Future<OperationStatusResponse> addWithImage(
      @Part() String title,
      @Part() String content,
      @Part() File image,
      @Part(name: 'user_id') int userId);

  @FormUrlEncoded()
  @POST('notes/addwithoutimage.php')
  Future<OperationStatusResponse> addWithoutImage(
      @Field('title') String title,
      @Field('content') String content,
      @Field('user_id') int userId);

  @DELETE('notes/delete.php')
  Future<OperationStatusResponse> delete(@Field('note_id') int noteId);
  @PUT('notes/edit.php')
  Future<OperationStatusResponse> edit(
    @Field('note_id') int noteId,
    @Field('title') String title,
    @Field('content') String content,
  );
  @GET('notes/view.php')
  Future<GetNotesResponse> view(
    @Field('user_id') int userId,
  );
}

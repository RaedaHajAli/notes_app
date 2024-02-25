import 'package:dio/dio.dart';

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
  Future<OperationStatusResponse> add(
      @Field('title') String title,
      @Field('content') String content,
      @Field('image') String image,
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

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fullnoteapp/data/network/app_api.dart';
import 'package:fullnoteapp/data/network/requests.dart';
import 'package:fullnoteapp/data/responses/responses.dart';

abstract class RemoteDataSource {
  //auth
  Future<AuthenticationResponse> signup(SignupRequest registerRequest);
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  //notes
  Future<OperationStatusResponse> addWithImage(
      AddNoteWithImageRequest addNoteWithImageRequest);
  Future<OperationStatusResponse> addWithoutImage(
      AddNoteWithoutImageRequest addNoteWithoutImageRequest);
  Future<OperationStatusResponse> edit(EditNoteRequest editNoteRequest);
  Future<OperationStatusResponse> delete(DeleteNoteRequest deleteNoteRequest);
  Future<GetNotesResponse> view(ViewNotesRequest viewNotesRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(
    this._appServiceClient,
  );

//auth
  @override
  Future<AuthenticationResponse> signup(SignupRequest signupRequest) async {
    return await _appServiceClient.signup(
      signupRequest.userName,
      signupRequest.email,
      signupRequest.password,
    );
  }

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

//notes
  @override
  Future<OperationStatusResponse> addWithImage(
      AddNoteWithImageRequest addNoteWithImageRequest) async {
    return await _appServiceClient.addWithImage(addNoteWithImageRequest.title,
       addNoteWithImageRequest.content, addNoteWithImageRequest.image, addNoteWithImageRequest.userId);
  }

  @override
  Future<OperationStatusResponse> addWithoutImage(
      AddNoteWithoutImageRequest addNoteWithoutImageRequest) async {
    return await _appServiceClient.addWithoutImage(addNoteWithoutImageRequest.title,
        addNoteWithoutImageRequest.content,  addNoteWithoutImageRequest.userId);
  }

  @override
  Future<OperationStatusResponse> edit(EditNoteRequest editNoteRequest) async {
    return await _appServiceClient.edit(
        editNoteRequest.noteId, editNoteRequest.title, editNoteRequest.content);
  }

  @override
  Future<OperationStatusResponse> delete(
      DeleteNoteRequest deleteNoteRequest) async {
    return await _appServiceClient.delete(deleteNoteRequest.noteId);
  }

  @override
  Future<GetNotesResponse> view(ViewNotesRequest viewNotesRequest) async {
    return await _appServiceClient.view(viewNotesRequest.userId);
  }
}

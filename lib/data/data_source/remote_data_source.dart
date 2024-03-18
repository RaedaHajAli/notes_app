// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fullnoteapp/data/network/app_api.dart';
import 'package:fullnoteapp/data/network/requests.dart';
import 'package:fullnoteapp/data/responses/responses.dart';

abstract class RemoteDataSource {
  //auth
  Future<AuthenticationResponse> signup(SignupRequest registerRequest);
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  //notes
  Future<OperationStatusResponse> add(
      AddNoteWithImageRequest addNoteWithImageRequest);
  
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
  Future<OperationStatusResponse> add(
      AddNoteWithImageRequest addNoteWithImageRequest) async {
          return await _appServiceClient.add(addNoteWithImageRequest.title,
          addNoteWithImageRequest.content, addNoteWithImageRequest.userId,
          image: addNoteWithImageRequest.image);
    // if (addNoteWithImageRequest.image != null) {
    
    // } else {
    //   return await _appServiceClient.add(
    //     addNoteWithImageRequest.title,
    //     addNoteWithImageRequest.content,
    //     addNoteWithImageRequest.userId,
    //   );
    // }
  }

  

  @override
  Future<OperationStatusResponse> edit(EditNoteRequest editNoteRequest) async {
    return await _appServiceClient.edit(
        editNoteRequest.noteId, editNoteRequest.title, editNoteRequest.content);
  }

  @override
  Future<OperationStatusResponse> delete(
      DeleteNoteRequest deleteNoteRequest) async {
    return await _appServiceClient.delete(
        deleteNoteRequest.noteId, deleteNoteRequest.imageName);
  }

  @override
  Future<GetNotesResponse> view(ViewNotesRequest viewNotesRequest) async {
    return await _appServiceClient.view(viewNotesRequest.userId);
  }
}

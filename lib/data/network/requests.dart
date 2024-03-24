// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class LoginRequest {
  String email;
  String password;
  LoginRequest(
    this.email,
    this.password,
  );
}

//Signup Request
class SignupRequest {
  String userName;
  String email;
  String password;

  SignupRequest(
    this.userName,
    this.email,
    this.password,
  );
}

//Notes
//Add Note
class AddNoteRequest {
  String title;
  String content;
  File? image;
  int userId;
  AddNoteRequest({
    required this.title,
    required this.content,
    required this.image,
    required this.userId,
  });
}

//edit note
class EditNoteRequest {
  int noteId;
  String title;
  String content;
  String imageName;
  File? newImage;
  EditNoteRequest({
    required this.noteId,
    required this.title,
    required this.content,
    required this.imageName,
    this.newImage,
  });
}

//delete note
class DeleteNoteRequest {
  int noteId;
  String imageName;
  DeleteNoteRequest({required this.noteId, required this.imageName});
}

// view notes
class ViewNotesRequest {
  int userId;
  ViewNotesRequest({
    required this.userId,
  });
}

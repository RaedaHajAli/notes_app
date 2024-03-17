import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../models/models.dart';

abstract class Repository {
  //auth
  Future<Either<Failure, User>> signup(SignupRequest registerRequest);
  Future<Either<Failure, User>> login(LoginRequest loginRequest);

  //notes
  Future<Either<Failure, OperationStatus>> addWithImage(
      AddNoteWithImageRequest addNoteRequest);
      Future<Either<Failure, OperationStatus>> addWithoutImage(
      AddNoteWithoutImageRequest addNoteWithoutImageReques);
  Future<Either<Failure, OperationStatus>> edit(
      EditNoteRequest editNoteRequest);
  Future<Either<Failure, OperationStatus>> delete(
      DeleteNoteRequest deleteNoteRequest);
  Future<Either<Failure, NotesList>> view(ViewNotesRequest viewNotesRequest);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:fullnoteapp/data/network/failure.dart';
import 'package:fullnoteapp/data/network/requests.dart';
import 'package:fullnoteapp/domain/models/models.dart';

import '../repository/repository.dart';
import 'base_usecase.dart';

class DeleteNoteUseCase
    implements BaseUseCase<DeleteNoteUseCaseInput, OperationStatus> {
  final Repository _repository;
  DeleteNoteUseCase(
    this._repository,
  );

  @override
  Future<Either<Failure, OperationStatus>> execute(
      DeleteNoteUseCaseInput input) async {
    return await _repository.delete(DeleteNoteRequest(noteId: input.noteId,imageName: input.imageName));
  }
}

class DeleteNoteUseCaseInput {
  int noteId;
  String imageName;
  DeleteNoteUseCaseInput({
    required this.noteId,
    required this.imageName,
  });
}

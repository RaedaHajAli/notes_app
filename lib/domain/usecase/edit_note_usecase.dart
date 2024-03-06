// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:fullnoteapp/data/network/failure.dart';
import 'package:fullnoteapp/data/network/requests.dart';
import 'package:fullnoteapp/domain/models/models.dart';
import 'package:fullnoteapp/domain/usecase/base_usecase.dart';

import '../repository/repository.dart';

class EditNoteUseCase
    implements BaseUseCase<EditNoteUseCaseInput, OperationStatus> {
  final Repository _repository;
  EditNoteUseCase(
    this._repository,
  );
  @override
  Future<Either<Failure, OperationStatus>> execute(
      EditNoteUseCaseInput input) async {
    return await _repository.edit(EditNoteRequest(
        noteId: input.noteId, title: input.title, content: input.content));
  }
}

class EditNoteUseCaseInput {
  int noteId;
  String title;
  String content;
  // String image;
  EditNoteUseCaseInput({
    required this.noteId,
    required this.title,
    required this.content,
    // required this.image
  });
}

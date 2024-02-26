// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:fullnoteapp/data/network/failure.dart';
import 'package:fullnoteapp/data/network/requests.dart';
import 'package:fullnoteapp/domain/models/models.dart';
import 'package:fullnoteapp/domain/usecase/base_usecase.dart';

import '../repository/repository.dart';

class ViewNoteUseCase implements BaseUseCase<ViewNoteUseCaseInput, NotesList> {
  final Repository _repository;
  ViewNoteUseCase(
    this._repository,
  );
  @override
  Future<Either<Failure, NotesList>> execute(ViewNoteUseCaseInput input) async {
    
    return await _repository.view(ViewNotesRequest(userId: input.userId));
  
  }
}

class ViewNoteUseCaseInput {
  int userId;
  ViewNoteUseCaseInput({
    required this.userId,
  });
}

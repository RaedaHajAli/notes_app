import 'package:dartz/dartz.dart';

import 'package:fullnoteapp/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../models/models.dart';
import '../repository/repository.dart';


class AddNoteWithoutImageUseCase
    implements BaseUseCase<AddNoteWithoutImageUseCaseInput, OperationStatus> {
  final Repository _repository;
  AddNoteWithoutImageUseCase(
    this._repository,
  );

  @override
  Future<Either<Failure, OperationStatus>> execute(
      AddNoteWithoutImageUseCaseInput input) async {
    return await _repository.addWithoutImage(AddNoteWithoutImageRequest(
        title: input.title,
        content: input.content,
       
        userId: input.userId));
  }
}

class AddNoteWithoutImageUseCaseInput {
  String title;
  String content;

  int userId;
  AddNoteWithoutImageUseCaseInput({
    required this.title,
    required this.content,
   
    required this.userId,
  });
}
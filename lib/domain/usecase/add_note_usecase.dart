// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:fullnoteapp/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../models/models.dart';
import '../repository/repository.dart';

class AddNoteUseCase
    implements BaseUseCase<AddNoteUseCaseInput, OperationStatus> {
  final Repository _repository;
  AddNoteUseCase(
    this._repository,
  );

  @override
  Future<Either<Failure, OperationStatus>> execute(
      AddNoteUseCaseInput input) async {
    return await _repository.add(AddNoteRequest(
        title: input.title,
        content: input.content,
        image: input.image,
        userId: input.userId));
  }
}



class AddNoteUseCaseInput {
  String title;
  String content;
  String image;
  int userId;
  AddNoteUseCaseInput({
    required this.title,
    required this.content,
    required this.image,
    required this.userId,
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:fullnoteapp/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../models/models.dart';
import '../repository/repository.dart';
import 'dart:io';

class AddNoteWithImageUseCase
    implements BaseUseCase<AddNoteWithImageUseCaseInput, OperationStatus> {
  final Repository _repository;
  AddNoteWithImageUseCase(
    this._repository,
  );

  @override
  Future<Either<Failure, OperationStatus>> execute(
      AddNoteWithImageUseCaseInput input) async {
    return await _repository.add(AddNoteWithImageRequest(
        title: input.title,
        content: input.content,
        image: input.image,
        userId: input.userId));
  }
}

class AddNoteWithImageUseCaseInput {
  String title;
  String content;
  File? image;
  int userId;
  AddNoteWithImageUseCaseInput({
    required this.title,
    required this.content,
    required this.image,
    required this.userId,
  });
}

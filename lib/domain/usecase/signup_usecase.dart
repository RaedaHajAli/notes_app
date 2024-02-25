// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import '../../domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';
import '../models/models.dart';
import '../repository/repository.dart';

import '../../data/network/requests.dart';

class SignupUseCase implements BaseUseCase<SignupUseCaseInput, User> {
  final Repository _repository;
  SignupUseCase(
    this._repository,
  );
  @override
  Future<Either<Failure, User>> execute(
      SignupUseCaseInput input) async {
    return await _repository.signup(SignupRequest(
      input.userName,
      input.email,
      input.password,
    ));
  }
}

class SignupUseCaseInput {
  String userName;

  String email;
  String password;

  SignupUseCaseInput(
    this.userName,
    this.email,
    this.password,
  );
}

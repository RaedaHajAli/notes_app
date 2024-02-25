// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/models.dart';
import '../repository/repository.dart';
import '../../domain/usecase/base_usecase.dart';

import '../../data/network/requests.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, User> {
  final Repository _repository;
  LoginUseCase(
    this._repository,
  );
  @override
  Future<Either<Failure, User>> execute(LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(
    this.email,
    this.password,
  );
}



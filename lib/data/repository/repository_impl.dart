// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import '../../domain/mapper/mapper.dart';

import '../../domain/models/models.dart';
import '../../domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';
import '../network/requests.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;

  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, User>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // there is internet connection

      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          //return either right

          return Right(response.data.toDomain());
        } else {
          //failure
          //with status code from api
          // return  either left

          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (e) {
        //dio exception
        //return either left by using error handler

        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      // internet connection error
      // return  either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signup(SignupRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      // there is internet connection

      try {
        final response = await _remoteDataSource.signup(registerRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          //return either right
          return Right(response.data.toDomain());
        } else {
          //failure
          //with status code from api
          // return  either left

          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (e) {
        //dio exception
        //return either left by using error handler

        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      // internet connection error
      // return  either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, OperationStatus>> add(
      AddNoteRequest addNoteRequest) async {
    if (await _networkInfo.isConnected) {
      // there is internet connection

      try {
        final response = await _remoteDataSource.add(addNoteRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          //return either right

          return Right(response.toDomain());
        } else {
          //failure
          //with status code from api
          // return  either left

          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (e) {
        //dio exception
        //return either left by using error handler

        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      // internet connection error
      // return  either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, OperationStatus>> delete(
      DeleteNoteRequest deleteNoteRequest) async {
    if (await _networkInfo.isConnected) {
      // there is internet connection

      try {
        final response = await _remoteDataSource.delete(deleteNoteRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          //return either right

          return Right(response.toDomain());
        } else {
          //failure
          //with status code from api
          // return  either left

          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (e) {
        //dio exception
        //return either left by using error handler

        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      // internet connection error
      // return  either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, OperationStatus>> edit(
      EditNoteRequest editNoteRequest) async {
    if (await _networkInfo.isConnected) {
      // there is internet connection

      try {
        final response = await _remoteDataSource.edit(editNoteRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          //return either right

          return Right(response.toDomain());
        } else {
          //failure
          //with status code from api
          // return  either left

          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (e) {
        //dio exception
        //return either left by using error handler

        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      // internet connection error
      // return  either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, NotesList>> view(
      ViewNotesRequest viewNotesRequest) async {
    if (await _networkInfo.isConnected) {
      // there is internet connection

      try {
        final response = await _remoteDataSource.view(viewNotesRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          //return either right

          return Right(response.toDomain());
        } else {
          //failure
          //with status code from api
          // return  either left

          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (e) {
        //dio exception
        //return either left by using error handler

        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      // internet connection error
      // return  either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';

import '../../../../domain/usecase/login_usecase.dart';
import '../../../common/freezed_data_classes.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(
    this._loginUseCase,
  ) : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isSecure = true;
  changeVisibility() {
    isSecure = !isSecure;
    emit(LoginChangeVisibilityStates());
  }

  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;

  autoValidate() {
    autovalidateMode = AutovalidateMode.always;
    emit(LoginAutoValidateStates());
  }

  final LoginUseCase _loginUseCase;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  login(LoginObject loginObject) async {
    emit(LoginLoadingStates());
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.email, loginObject.password)))
        .fold((failure) {
      emit(LoginFailureStates(message: failure.message));
    }, (user) async {
      

      _appPreferences.setUserData(user);
      emit(LoginSuccessStates());
    });
  }

 
}

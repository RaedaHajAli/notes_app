// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/presentation/common/freezed_data_classes.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../../domain/usecase/signup_usecase.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit(
    this._signupUseCase,
  ) : super(SignupInitialStates());
  final SignupUseCase _signupUseCase;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  static SignupCubit get(context) => BlocProvider.of(context);

  bool isSecure = true;
  changeVisibility() {
    isSecure = !isSecure;
    emit(SignupChangeVisibilityStates());
  }
   AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;

  autoValidate() {
    autovalidateMode = AutovalidateMode.always;
    emit(SignupAutoValidateStates());
  }

  signup(SignupObject signupObject) async {
    emit(SignupLoadingStates());

    (await _signupUseCase.execute(SignupUseCaseInput(
            signupObject.userName, signupObject.email, signupObject.password)))
        .fold((failure) {
           emit(SignupFailureStates(message: failure.message));
        }, (user) async {
      await _appPreferences.setUserData(user);
      emit(SignupSuccessStates());
    });
  }

}

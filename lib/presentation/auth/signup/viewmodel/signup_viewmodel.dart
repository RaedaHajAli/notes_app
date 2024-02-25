import 'dart:async';
import 'package:dartz/dartz.dart';


import 'package:fullnoteapp/app/functions.dart';

import 'package:fullnoteapp/domain/usecase/signup_usecase.dart';
import 'package:fullnoteapp/presentation/base/base_viewmodel.dart';
import 'package:fullnoteapp/presentation/common/freezed_data_classes.dart';

import '../../../../data/network/failure.dart';
import '../../../../domain/models/models.dart';
import '../../../resources/strings_manager.dart';

class SignupViewModel extends BaseViewModel
    with SignupViewModelInputs, SignupViewModelOutputs {
  final StreamController _userNameController =
      StreamController<String>.broadcast();
  final StreamController _emailController =
      StreamController<String>.broadcast();
  final StreamController _passwordController =
      StreamController<String>.broadcast();
  final StreamController _allInputsStreamController =
      StreamController<void>.broadcast();
  SignupObject signupObject = SignupObject('', '', '');
  final SignupUseCase _signupUseCase;

  SignupViewModel(this._signupUseCase);

  @override
  void start() {
    super.start();
  }

  @override
  void dispose() {
    _userNameController.close();
    _emailController.close();
    _passwordController.close();
    super.dispose();
  }
  //inputs

  @override
  Sink get inputUserName => _userNameController.sink;
  @override
  Sink get inputEmail => _emailController.sink;

  @override
  Sink get inputPassword => _passwordController.sink;

  @override
  Sink get inputAllInputsValid => _allInputsStreamController.sink;

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      signupObject = signupObject.copyWith(userName: userName);
    } else {
      signupObject = signupObject.copyWith(userName: '');
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      signupObject = signupObject.copyWith(email: email);
    } else {
      signupObject = signupObject.copyWith(email: '');
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      signupObject = signupObject.copyWith(password: password);
    } else {
      signupObject = signupObject.copyWith(password: '');
    }
    _validate();
  }

  @override
  Future<Either<Failure, User>> signup() async {
    return await _signupUseCase.execute(SignupUseCaseInput(
            signupObject.userName, signupObject.email, signupObject.password));
     
  }

//outputs

  @override
  Stream<bool> get outputIsUserNameValid =>
      _userNameController.stream.map((userName) => _isUserNameValid(userName));
  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid.map(
      (isUserNameValid) => isUserNameValid ? null : AppStrings.userNameError);

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailController.stream.map((email) => isEmailValid(email));
  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : AppStrings.emailError);

  @override
  Stream<bool> get outputIsPasswordeValid =>
      _passwordController.stream.map((password) => _isPasswordValid(password));
  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordeValid.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.passwordError);

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _allInputsStreamController.stream.map((_) => _areAllInputsValid());

  //private functions
  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }

  bool _areAllInputsValid() {
    return signupObject.userName.isNotEmpty &&
        signupObject.email.isNotEmpty &&
        signupObject.password.isNotEmpty;
  }
}

mixin SignupViewModelInputs {
  setUserName(String userName);
  setEmail(String email);
  setPassword(String password);
  signup();
  Sink get inputUserName;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputAllInputsValid;
}
mixin SignupViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;
  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;
  Stream<bool> get outputIsPasswordeValid;
  Stream<String?> get outputErrorPassword;
  Stream<bool> get outputAreAllInputsValid;
}

import 'dart:async';


import 'package:fullnoteapp/app/functions.dart';

import 'package:fullnoteapp/presentation/base/base_viewmodel.dart';
import 'package:fullnoteapp/presentation/common/freezed_data_classes.dart';


import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../../domain/usecase/login_usecase.dart';
import '../../../resources/strings_manager.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _emailController =
      StreamController<String>.broadcast();
  final StreamController _passwordController =
      StreamController<String>.broadcast();
  final StreamController _allInputsStreamController =
      StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();
  LoginObject loginObject = LoginObject('', '');
  final LoginUseCase _loginUseCase;
   final AppPreferences _appPreferences = instance<AppPreferences>();

  LoginViewModel(this._loginUseCase);

  @override
  void start() {
    super.start();
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    isUserLoggedInSuccessfullyStreamController.close();
    super.dispose();
  }
  //inputs

  @override
  Sink get inputEmail => _emailController.sink;

  @override
  Sink get inputPassword => _passwordController.sink;

  @override
  Sink get inputAllInputsValid => _allInputsStreamController.sink;

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      loginObject = loginObject.copyWith(email: email);
    } else {
      loginObject = loginObject.copyWith(email: '');
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      loginObject = loginObject.copyWith(password: password);
    } else {
      loginObject = loginObject.copyWith(password: '');
    }
    _validate();
  }

  @override
  login() async {
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.email, loginObject.password)))
        .fold((failure) {
      print(failure.message);
    }, (user) async{
       isUserLoggedInSuccessfullyStreamController.add(true);
         await _appPreferences.setUserLoggedIn();
      _appPreferences.setUserData(user);
      print(user.email);
    });
  }

//outputs

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

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }

  bool _areAllInputsValid() {
    return loginObject.email.isNotEmpty && loginObject.password.isNotEmpty;
  }
}

mixin LoginViewModelInputs {
  setEmail(String email);
  setPassword(String password);
  login();

  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputAllInputsValid;
}
mixin LoginViewModelOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;
  Stream<bool> get outputIsPasswordeValid;
  Stream<String?> get outputErrorPassword;
  Stream<bool> get outputAreAllInputsValid;
}

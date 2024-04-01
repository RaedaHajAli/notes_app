// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class LoginStates {}

class LoginInitialStates extends LoginStates {}

class LoginLoadingStates extends LoginStates {}

class LoginSuccessStates extends LoginStates {}

class LoginFailureStates extends LoginStates {
  String message;
  LoginFailureStates({
    required this.message,
  });
  
}

class LoginChangeVisibilityStates extends LoginStates {}
class LoginAutoValidateStates extends LoginStates {}

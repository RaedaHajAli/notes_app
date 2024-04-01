// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class SignupStates {}

class SignupInitialStates extends SignupStates {}

class SignupSuccessStates extends SignupStates {}

class SignupLoadingStates extends SignupStates {}

class SignupFailureStates extends SignupStates {
  String message;
  SignupFailureStates({
    required this.message,
  });
}

class SignupChangeVisibilityStates extends SignupStates {}
class SignupAutoValidateStates extends SignupStates {}


import 'package:flutter_bloc/flutter_bloc.dart';

import 'signup_state.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialStates());

  static SignupCubit get(context) => BlocProvider.of(context);

  bool isSecure = true;
  changeVisibility() {
    isSecure = !isSecure;
    emit(SignupChangeVisibilityStates());
  }
}

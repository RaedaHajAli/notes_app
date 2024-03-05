import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isSecure = true;
  changeVisibility() {
    isSecure = !isSecure;
    emit(LoginChangeVisibilityStates());
  }
}

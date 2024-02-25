import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/presentation/resources/route_manager.dart';

import '../../../../../app/di.dart';
import '../../../../app/app_prefs.dart';
import '../../../common/widgets/widgets.dart';
import '../../../resources/strings_manager.dart';
import '../viewmodel/login_viewmodel.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginViewModel viewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  bool isSecure = true;
  changeVisibility() {
    isSecure = !isSecure;
    emit(LoginChangeVisibilityStates());
  }

  bool loading = false;
  login(BuildContext context) async {
    loading = true;
    emit(LoginLoadingStates());
    // Future.delayed(Duration(seconds: 2))
    // .then((value) async {

    // });

    (await viewModel.login()).fold((failure) {
      ScaffoldMessenger.of(context).showSnackBar(buildFailureSnackBar(
          title: AppStrings.failureLogin, message: failure.message));
    }, (user) async {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homeRoute, (route) => false);
     

      await _appPreferences.setUserLoggedIn();
      _appPreferences.setUserData(user);
    });

    loading = false;
    emit(LoginLoadingStates());
  }
}

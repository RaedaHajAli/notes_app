import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/presentation/resources/strings_manager.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';

import '../../../common/widgets/widgets.dart';
import '../../../resources/route_manager.dart';
import '../../viewmodel/signup_viewmodel.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialStates());

  static SignupCubit get(context) => BlocProvider.of(context);
  SignupViewModel viewModel = instance<SignupViewModel>();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  bool isSecure = true;
  changeVisibility() {
    isSecure = !isSecure;
    emit(SignupChangeVisibilityStates());
  }

  bool loading = false;
  signup(BuildContext context) async {
    loading = true;
    emit(SignupLoadingStates());
    // Future.delayed(Duration(seconds: 2))
    // .then((value) async {

    // });

    (await viewModel.signup()).fold((failure) {
      print(failure.message);
      ScaffoldMessenger.of(context).showSnackBar(buildFailureSnackBar(
          title: AppStrings.failureLogin, message: failure.message));
    }, (user) async {
    
           Navigator.pushNamedAndRemoveUntil(
          context, Routes.homeRoute, (route) => false);
      await _appPreferences.setUserLoggedIn();
      _appPreferences.setUserData(user);
    

      // ScaffoldMessenger.of(context)
      //     .showSnackBar(buildWelcomeSnackBar(data.username));
    });
    // viewModel.signup();
    loading = false;
    emit(SignupLoadingStates());
  }
}

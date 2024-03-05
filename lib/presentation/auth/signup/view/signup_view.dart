import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/presentation/auth/signup/viewmodel/signup_viewmodel.dart';

import 'package:fullnoteapp/presentation/resources/color_manager.dart';

import 'package:fullnoteapp/presentation/auth/signup/view/cubit/signup_cubit.dart';
import 'package:fullnoteapp/presentation/auth/signup/view/cubit/signup_state.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../common/widgets/widgets.dart';
import '../../../resources/route_manager.dart';
import '../../../resources/strings_manager.dart';

import '../../widgets.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  SignupViewModel _viewModel = instance<SignupViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late SignupCubit cubit;

  _bind() {
    _viewModel.start();

    _userNameController.addListener(() {
      _viewModel.setUserName(_userNameController.text);
    });
    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        //Navigate to home screen
        _appPreferences.setUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.homeRoute);

        // SchedulerBinding.instance.addPostFrameCallback((_) {

        // });
      }
    });
  }

  @override
  void dispose() {
    _userNameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bind();
    cubit = SignupCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupStates>(builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColor.deepPurple,
        body: Form(
          key: formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AuthScreenLogo(),
                    buildLable(AppStrings.userName),
                    StreamBuilder<String?>(
                        stream: _viewModel.outputErrorUserName,
                        builder: (context, snapshot) {
                          return buildCustomTextField(
                            controller: _userNameController,
                            keyboardType: TextInputType.name,
                            hint: AppStrings.userName,
                            prefix: Icons.person,
                            borderColor: AppColor.grey.withOpacity(0.1),
                            contentColor: AppColor.white,
                            backgroundColor: AppColor.mediumPurple,
                            errorText: snapshot.data,
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    buildLable(AppStrings.email),
                    StreamBuilder<String?>(
                        stream: _viewModel.outputErrorEmail,
                        builder: (context, snapshot) {
                          return buildCustomTextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            hint: AppStrings.email,
                            prefix: Icons.email,
                            borderColor: AppColor.grey.withOpacity(0.1),
                            contentColor: AppColor.white,
                            backgroundColor: AppColor.mediumPurple,
                            errorText: snapshot.data,
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    buildLable(AppStrings.password),
                    StreamBuilder<String?>(
                        stream: _viewModel.outputErrorPassword,
                        builder: (context, snapshot) {
                          return BlocBuilder<SignupCubit, SignupStates>(
                            builder: (context, state) {
                              return buildCustomTextField(
                                controller: _passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                hint: AppStrings.password,
                                prefix: Icons.lock,
                                suffixIcon: cubit.isSecure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                borderColor: AppColor.grey.withOpacity(0.1),
                                contentColor: AppColor.white,
                                backgroundColor: AppColor.mediumPurple,
                                errorText: snapshot.data,
                                obscureText: cubit.isSecure,
                                suffixPressed: () {
                                  cubit.changeVisibility();
                                },
                              );
                            },
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<bool>(
                        stream: _viewModel.outputAreAllInputsValid,
                        builder: (context, snapshot) {
                          return buildCustomButton(
                              title: AppStrings.signup,
                              textColor: Colors.white,
                              backgroundColor: AppColor.pink.withOpacity(0.9),
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.signup();
                                    }
                                  : null);
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthFooter(
                      mainPhrase: AppStrings.alreadyHaveAccount,
                      buttonTitle: AppStrings.login,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              )),
        ),
      );
    });
  }
}

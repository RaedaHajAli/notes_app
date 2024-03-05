import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fullnoteapp/presentation/auth/login/cubit/login_cubit.dart';
import 'package:fullnoteapp/presentation/auth/login/viewmodel/login_viewmodel.dart';
import 'package:fullnoteapp/presentation/resources/color_manager.dart';
import 'package:fullnoteapp/presentation/resources/route_manager.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../common/widgets/widgets.dart';
import '../../../resources/strings_manager.dart';
import '../../widgets.dart';
import '../cubit/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _SignupViewState();
}

class _SignupViewState extends State<LoginView> {
  LoginViewModel viewModel = instance<LoginViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginCubit cubit;

  _bind() {
    viewModel.start();
    _emailController.addListener(() {
      viewModel.setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      viewModel.setPassword(_passwordController.text);
    });
    viewModel.isUserLoggedInSuccessfullyStreamController.stream
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
    _emailController.clear();
    _passwordController.clear();
    viewModel.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _bind();
    cubit = LoginCubit.get(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deepPurple,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthScreenLogo(),
                buildLable(AppStrings.email),
                StreamBuilder<String?>(
                    stream: viewModel.outputErrorEmail,
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
                    stream: viewModel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return BlocBuilder<LoginCubit, LoginStates>(
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
                            obscureText: cubit.isSecure,
                            suffixPressed: () {
                              cubit.changeVisibility();
                            },
                            errorText: snapshot.data,
                          );
                        },
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<bool>(
                    stream: viewModel.outputAreAllInputsValid,
                    builder: (context, snapshot) {
                      return buildCustomButton(
                          title: AppStrings.login,
                          textColor: Colors.white,
                          backgroundColor: AppColor.pink.withOpacity(0.9),
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  viewModel.login();
                                }
                              : null);
                    }),
                const SizedBox(
                  height: 15,
                ),
                AuthFooter(
                  mainPhrase: AppStrings.dontHaveAccount,
                  buttonTitle: AppStrings.signup,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      Routes.signupRoute,
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}

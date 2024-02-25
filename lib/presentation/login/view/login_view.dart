import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/presentation/common/widgets/widgets.dart';
import 'package:fullnoteapp/presentation/login/cubit/login_cubit.dart';
import 'package:fullnoteapp/presentation/resources/color_manager.dart';
import 'package:fullnoteapp/presentation/resources/route_manager.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../resources/images_manager.dart';
import '../../resources/strings_manager.dart';
import '../cubit/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _SignupViewState();
}

class _SignupViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = LoginCubit.get(context);
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: cubit.loading,
          child: Scaffold(
            backgroundColor: AppColor.deepPurple,
            body: Form(
              key: formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Row(
                          children: [
                            Image.asset(
                               AppImages.logo,
                              width: 90,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  AppStrings.noteApp,
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  AppStrings.noteSubTitle,
                                  style: TextStyle(
                                    color: AppColor.white.withOpacity(0.6),
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        buildLable(AppStrings.email),
                        StreamBuilder<String?>(
                          stream: cubit.viewModel.outputErrorEmail,
                          builder: (context, snapshot) {
                            return buildCustomTextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                hint: AppStrings.email,
                                prefix: Icons.email,
                                borderColor: AppColor.grey.withOpacity(0.1),
                                contentColor: AppColor.white,
                                backgroundColor: AppColor.mediumPurple,
                                errorText: snapshot.data,
                                onChanged: (email) {
                                  cubit. viewModel.setEmail(email);
                                  }
                                );
                          }
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buildLable(AppStrings.password),
                        StreamBuilder<String?>(
                          stream: cubit.viewModel.outputErrorPassword,
                          builder: (context, snapshot) {
                            return buildCustomTextField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                hint: AppStrings.password,
                                prefix: Icons.lock,
                                suffixIcon:cubit.isSecure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                borderColor: AppColor.grey.withOpacity(0.1),
                                contentColor: AppColor.white,
                                backgroundColor: AppColor.mediumPurple,
                                obscureText:cubit.isSecure,
                                  suffixPressed: () {
                                    cubit.changeVisibility();
                                  },
                                errorText: snapshot.data,
                                 onChanged: (password) {
                                   cubit. viewModel.setPassword(password);
                                  }
                                );
                          }
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<bool>(
                          stream: cubit.viewModel.outputAreAllInputsValid,
                          builder: (context, snapshot) {
                            return buildCustomButton(
                                title: AppStrings.login,
                                textColor: Colors.white,
                                backgroundColor: AppColor.pink.withOpacity(0.9),
                                onPressed: (snapshot.data ?? false)
                                          ? () {
                                           cubit.login(context);
                                            }
                                          : null
                                );
                          }
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              AppStrings.dontHaveAccount,
                              style: TextStyle(color: AppColor.white),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    Routes.signupRoute,
                                  );
                                  ;
                                },
                                child: const Text(AppStrings.signup,
                                    style: TextStyle(color: AppColor.pink)))
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fullnoteapp/presentation/resources/color_manager.dart';

import 'package:fullnoteapp/presentation/auth/signup/view/cubit/signup_cubit.dart';
import 'package:fullnoteapp/presentation/auth/signup/view/cubit/signup_state.dart';

import '../../../resources/strings_manager.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../widgets.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SignupCubit cubit = SignupCubit.get(context);
    return BlocBuilder<SignupCubit, SignupStates>(builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: cubit.loading,
        child: Scaffold(
          backgroundColor: AppColor.deepPurple,
          body: SignupBody(formKey: formKey, cubit: cubit),
        ),
      );
    });
  }
}

class SignupBody extends StatelessWidget {
  const SignupBody({
    super.key,
    required this.formKey,
    required this.cubit,
  });

  final GlobalKey<FormState> formKey;
  final SignupCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
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
                    stream: cubit.viewModel.outputErrorUserName,
                    builder: (context, snapshot) {
                      return buildCustomTextField(
                      
                          keyboardType: TextInputType.name,
                          hint: AppStrings.userName,
                          prefix: Icons.person,
                          borderColor: AppColor.grey.withOpacity(0.1),
                          contentColor: AppColor.white,
                          backgroundColor: AppColor.mediumPurple,
                          errorText: snapshot.data,
                          onChanged: (userName) {
                            cubit.viewModel.setUserName(userName);
                          });
                    }),
                const SizedBox(
                  height: 20,
                ),
                buildLable(AppStrings.email),
                StreamBuilder<String?>(
                    stream: cubit.viewModel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return buildCustomTextField(
                        
                          keyboardType: TextInputType.emailAddress,
                          hint: AppStrings.email,
                          prefix: Icons.email,
                          borderColor: AppColor.grey.withOpacity(0.1),
                          contentColor: AppColor.white,
                          backgroundColor: AppColor.mediumPurple,
                          errorText: snapshot.data,
                          onChanged: (email) {
                            cubit.viewModel.setEmail(email);
                          });
                    }),
                const SizedBox(
                  height: 20,
                ),
                buildLable(AppStrings.password),
                StreamBuilder<String?>(
                    stream: cubit.viewModel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return buildCustomTextField(
                          // controller: passwordController,
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
                          onChanged: (password) {
                            cubit.viewModel.setPassword(password);
                          });
                    }),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<bool>(
                    stream: cubit.viewModel.outputAreAllInputsValid,
                    builder: (context, snapshot) {
                      return buildCustomButton(
                          title: AppStrings.signup,
                          textColor: Colors.white,
                          backgroundColor: AppColor.pink.withOpacity(0.9),
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  cubit.signup(context);
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
    );
  }
}



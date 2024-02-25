import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/presentation/common/widgets/widgets.dart';
import 'package:fullnoteapp/presentation/resources/color_manager.dart';
import 'package:fullnoteapp/presentation/resources/images_manager.dart';
import 'package:fullnoteapp/presentation/signup/view/cubit/signup_cubit.dart';
import 'package:fullnoteapp/presentation/signup/view/cubit/signup_state.dart';



import '../../resources/strings_manager.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
 

  @override
  Widget build(BuildContext context) {
    SignupCubit cubit = SignupCubit.get(context);
    return BlocBuilder<SignupCubit,SignupStates>(
      builder: (context,state) {
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
                        buildLable(AppStrings.userNmae),
                        StreamBuilder<String?>(
                            stream:cubit. viewModel.outputErrorUserName,
                            builder: (context, snapshot) {
                              return buildCustomTextField(
                                  controller: usernameController,
                                  keyboardType: TextInputType.name,
                                  hint: AppStrings.userNmae,
                                  prefix: Icons.person,
                                  borderColor: AppColor.grey.withOpacity(0.1),
                                  contentColor: AppColor.white,
                                  backgroundColor: AppColor.mediumPurple,
                                  errorText: snapshot.data,
                                  onChanged: (userName) {
                                   cubit. viewModel.setUserName(userName);
                                  });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        buildLable(AppStrings.email),
                        StreamBuilder<String?>(
                            stream:cubit.viewModel.outputErrorEmail,
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
                                  });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        buildLable(AppStrings.password),
                        StreamBuilder<String?>(
                            stream:cubit.viewModel.outputErrorPassword,
                            builder: (context, snapshot) {
                              return buildCustomTextField(
                                  controller: passwordController,
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
                                   cubit. viewModel.setPassword(password);
                                  });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<bool>(
                            stream:cubit. viewModel.outputAreAllInputsValid,
                            builder: (context, snapshot) {
                              return buildCustomButton(
                                  title: AppStrings.signup,
                                  textColor: Colors.white,
                                  backgroundColor: AppColor.pink.withOpacity(0.9),
                                  onPressed:
                                  
                                      (snapshot.data ?? false)
                                          ? () {
                                           cubit.signup(context);
                                            }
                                          : null);
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              AppStrings.alreadyHaveAccount,
                              style: TextStyle(color: AppColor.white),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(AppStrings.login,
                                    style: TextStyle(color: AppColor.pink)))
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ),
        );
      }
    );
  }
}

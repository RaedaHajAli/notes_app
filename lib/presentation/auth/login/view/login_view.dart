import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fullnoteapp/presentation/auth/login/cubit/login_cubit.dart';
import 'package:fullnoteapp/presentation/resources/color_manager.dart';
import 'package:fullnoteapp/presentation/resources/route_manager.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


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
            body: LoginBody(formKey: formKey, cubit: cubit),
          ),
        );
      },
    );
  }

}

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
    required this.formKey,
    required this.cubit,
  });

  final GlobalKey<FormState> formKey;
  final LoginCubit cubit;

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

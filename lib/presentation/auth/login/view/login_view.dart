import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fullnoteapp/presentation/auth/login/cubit/login_cubit.dart';
import 'package:fullnoteapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:fullnoteapp/presentation/resources/color_manager.dart';
import 'package:fullnoteapp/presentation/resources/route_manager.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../../app/functions.dart';
import '../../../common/freezed_data_classes.dart';
import '../../../common/state_renderer/state_renderer_impl.dart';
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
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  late LoginCubit cubit;

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();

    super.dispose();
  }

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deepPurple,
      body: BlocBuilder<LoginCubit, LoginStates>(builder: (context, state) {
        FlowState flowState;
        if (state is LoginLoadingStates) {
          flowState = LoadingState(
              stateRendererType: StateRendererType.popupLoadingState);
        } else if (state is LoginFailureStates) {
          flowState =
              ErrorState(StateRendererType.popupErrorState, state.message);
        } else if (state is LoginSuccessStates) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            // Navigate to home screen
            _appPreferences.setUserLoggedIn();

            Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
          });
          flowState = ContentState();
        } else {
          flowState = ContentState();
        }
        return flowState.getScreenWidget(context, _getContentWidget(), () {});
      }),
    );
  }

  Widget _getContentWidget() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: cubit.autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthScreenLogo(),
                 const LabelText( title:AppStrings.email),
                  CustomTextField(
                  controller: _emailController,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  hint: AppStrings.email,
                  prefix: Icons.email,
                  borderColor: AppColor.grey.withOpacity(0.1),
                  contentColor: AppColor.white,
                  backgroundColor: AppColor.mediumPurple,
                ),
                const SizedBox(
                  height: 20,
                ),
                const LabelText( title:AppStrings.password),
                BlocBuilder<LoginCubit, LoginStates>(
                  builder: (context, state) {
                    return CustomTextField(
                      controller: _passwordController,
                      validator: validatePassword,
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
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    title: AppStrings.login,
                    textColor: Colors.white,
                    backgroundColor: AppColor.pink.withOpacity(0.9),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.login(LoginObject(
                            _emailController.text, _passwordController.text));
                      } else {
                        cubit.autoValidate();
                      }
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
          ),
        ));
  }
}

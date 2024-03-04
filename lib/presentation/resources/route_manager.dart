import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fullnoteapp/app/di.dart';
import 'package:fullnoteapp/presentation/auth/login/cubit/login_cubit.dart';

import 'package:fullnoteapp/presentation/auth/login/view/login_view.dart';
import 'package:fullnoteapp/presentation/auth/signup/view/cubit/signup_cubit.dart';

import 'package:fullnoteapp/presentation/auth/signup/view/signup_view.dart';
import 'package:fullnoteapp/presentation/home/cubit/home_cubit.dart';
import 'package:fullnoteapp/presentation/note_details/view/note_details_view.dart';

import '../home/view/home_view.dart';

import '../../presentation/resources/strings_manager.dart';

class Routes {
  static const String loginRoute = '/';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';
  static const String noteDetailsRoute = '/noteDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(
            builder: (_) => BlocProvider<LoginCubit>(
                  create: (context) => LoginCubit(),
                  child: const LoginView(),
                ));
      case Routes.signupRoute:
        initSignupModule();
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SignupCubit>(
                  create: (context) => SignupCubit(),
                  child: const SignupView(),
                ));
      case Routes.homeRoute:
        initHomeModule();

        return MaterialPageRoute(
            builder: (_) =>  const HomeView(),
                );
      case Routes.noteDetailsRoute:
        final note = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (_) => NoteDetailsView(
                  note: note,
                ));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}

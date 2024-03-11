import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fullnoteapp/app/di.dart';
import 'package:fullnoteapp/presentation/auth/login/cubit/login_cubit.dart';

import 'package:fullnoteapp/presentation/auth/login/view/login_view.dart';
import 'package:fullnoteapp/presentation/auth/signup/view/cubit/signup_cubit.dart';

import 'package:fullnoteapp/presentation/auth/signup/view/signup_view.dart';

import 'package:fullnoteapp/presentation/notes/note_details/note_details_view.dart';
import 'package:fullnoteapp/presentation/splash/splash_view.dart';

import '../notes/home/home_view.dart';


import '../../presentation/resources/strings_manager.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';
  static const String noteDetailsRoute = '/noteDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
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
          builder: (_) => const HomeView(),
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

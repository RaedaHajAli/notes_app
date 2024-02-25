import 'package:flutter/material.dart';
import 'package:fullnoteapp/presentation/resources/route_manager.dart';

import '../domain/models/models.dart';
import 'app_prefs.dart';
import 'di.dart';

class MyApp extends StatefulWidget {
  MyApp._internal(); //named constructor
  static final instance = MyApp._internal();
  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  var route = Routes.loginRoute;

  @override
  Widget build(BuildContext context) {
    // bool isLoggedIn = _appPreferences.isUserLoggedIn();
    User? user = _appPreferences.getUserData();
    if (user!=null) {
      route = Routes.homeRoute;
    } else {
      route = Routes.loginRoute;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: route,
    );
  }
}

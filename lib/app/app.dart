import 'package:flutter/material.dart';

import 'package:fullnoteapp/presentation/resources/route_manager.dart';



class MyApp extends StatefulWidget {
  MyApp._internal(); //named constructor
  static final instance = MyApp._internal();
  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
 

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}

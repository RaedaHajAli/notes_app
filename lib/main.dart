import 'package:flutter/material.dart';
import 'package:fullnoteapp/app/app.dart';
import 'package:fullnoteapp/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initModule();
  runApp(MyApp());
}

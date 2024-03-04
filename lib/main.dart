import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fullnoteapp/app/app.dart';
import 'package:fullnoteapp/app/di.dart';

import 'app/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initModule();
 Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

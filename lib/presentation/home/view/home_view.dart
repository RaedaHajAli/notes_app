import 'package:flutter/material.dart';
import 'package:fullnoteapp/presentation/resources/color_manager.dart';


import '../../../app/app_prefs.dart';

import '../../../app/di.dart';

import '../../resources/route_manager.dart';
import 'widgets/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deepPurple,
      appBar: AppBar(
        backgroundColor: AppColor.deepPurple,
        title: const Text('Notes'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                _appPreferences.logout();
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              },
              icon: const Icon(Icons.power_settings_new_outlined))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: List.generate(14, (index) {
                Color backgroundColor =
                    AppColor.notesColor[index % AppColor.notesColor.length];

                return NoteItem(backgroundColor: backgroundColor);
              }))),
      floatingActionButton: const AddFab(),
    );
  }
}




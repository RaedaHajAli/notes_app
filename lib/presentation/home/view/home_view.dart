import 'package:flutter/material.dart';
import 'package:fullnoteapp/presentation/resources/color_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';

import '../../resources/route_manager.dart';
import 'widgets/note_item.dart';

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
      appBar: AppBar(
        backgroundColor: AppColor.deepPurple,
        title: Text('Notes'),
        centerTitle: true,
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
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.separated(
          itemBuilder: (context, index) => const NoteItem(),
          separatorBuilder: (context, index) => const Divider(
            thickness: 1,
          ),
          itemCount: 10,
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}

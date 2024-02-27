import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/domain/models/models.dart';
import 'package:fullnoteapp/presentation/home/cubit/home_cubit.dart';
import 'package:fullnoteapp/presentation/home/cubit/home_state.dart';
import 'package:fullnoteapp/presentation/home/viewmodel/home_viewmodel.dart';
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
  HomeCubit cubit = HomeCubit();

  @override
  void initState() {
    cubit.homeViewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
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
          body: StreamBuilder<HomeViewObject>(
              stream: cubit.homeViewModel.outputHomeViewObject,
              builder: (context, snapshot) {
                if (snapshot.data?.notes.isEmpty ?? true) {
                  return const Center(
                      child: Text(
                    'There isn\'t any note yet',
                    style: TextStyle(color: AppColor.white, fontSize: 25),
                  ));
                } else {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      child: GridView.count(
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 3 : 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          children: List.generate(snapshot.data!.notes.length,
                              (index) {
                            Color backgroundColor = AppColor
                                .notesColor[index % AppColor.notesColor.length];

                            return NoteItem(
                              backgroundColor: backgroundColor,
                              note: snapshot.data!.notes[index],
                              onPressedDelete: () {
                                cubit
                                    .deleteNote(snapshot.data!.notes[index].id);
                              },
                              onTapNote: () {
                                Navigator.pushNamed(
                                    context, Routes.noteDetailsRoute,
                                    arguments: snapshot.data!.notes[index].toJson()
                                    
                                    );
                              },
                            );
                          })));
                }
              }),
          floatingActionButton: const AddFab(),
        );
      },
    );
  }
}

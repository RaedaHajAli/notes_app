import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fullnoteapp/presentation/home/cubit/home_cubit.dart';
import 'package:fullnoteapp/presentation/home/cubit/home_state.dart';

import 'package:fullnoteapp/presentation/resources/color_manager.dart';

import '../../../domain/models/models.dart';
import '../../resources/route_manager.dart';
import '../../resources/strings_manager.dart';
import '../viewmodel/home_viewmodel.dart';
import 'widgets/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<HomeCubit>(context);
    cubit.homeViewModel.start();
  }

  @override
  void dispose() {
    cubit.homeViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.deepPurple,
          appBar: buildHomeAppBar(context),
          body: buildHomeBody(),
          floatingActionButton: const AddFab(),
        );
      },
    );
  }

  BlocBuilder<HomeCubit, HomeStates> buildHomeBody() {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        return StreamBuilder<HomeViewObject>(
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
                        children:
                            List.generate(snapshot.data!.notes.length, (index) {
                          Color backgroundColor = AppColor
                              .notesColor[index % AppColor.notesColor.length];

                          return buildNoteItem(backgroundColor,
                              snapshot.data!.notes[index], context);
                        })));
              }
            });
      },
    );
  }

  NoteItem buildNoteItem(
      Color backgroundColor, Note note, BuildContext context) {
    return NoteItem(
      backgroundColor: backgroundColor,
      note: note,
      onPressedDelete: () {
        cubit.deleteNote(note.id);
      },
      onTapNote: () {
        Navigator.pushNamed(context, Routes.noteDetailsRoute,
            arguments: note.toJson());
      },
    );
  }
 
}

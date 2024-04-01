import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/presentation/notes/cubit/note_cubit.dart';
import 'package:fullnoteapp/presentation/notes/cubit/note_states.dart';

import 'package:fullnoteapp/presentation/notes/home/widgets/empty_home.dart';

import 'package:fullnoteapp/presentation/resources/color_manager.dart';

import '../../../../domain/models/models.dart';

import '../../resources/route_manager.dart';

import 'widgets/fab.dart';
import 'widgets/note_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late NoteCubit cubit;
  List<Note> notes = [];

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    cubit.getNotes();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deepPurple,
      appBar:buildHomeAppBar(context),
      body: _getContentWidget(),
      floatingActionButton: const Fab(),
    );
  }

  //App bar
  AppBar buildHomeAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.deepPurple,
      title: const Text('Notes'),
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {
              cubit.logout();
              Navigator.pushReplacementNamed(context, Routes.loginRoute);
            },
            icon: const Icon(Icons.power_settings_new_outlined))
      ],
    );
  }

//Home
  Widget _getContentWidget() {
    return BlocBuilder<NoteCubit, NoteStates>(builder: (context, state) {
      notes = cubit.notes;
      if (notes.isEmpty) {
        return const EmptyHome();
      } else {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: List.generate(notes.length, (index) {
                  Color backgroundColor =
                      AppColor.notesColor[index % AppColor.notesColor.length];

                  return buildNoteItem(backgroundColor, notes[index], context);
                })));
      }
    });
  }

  NoteItem buildNoteItem(
      Color backgroundColor, Note note, BuildContext context) {
    return NoteItem(
      backgroundColor: backgroundColor,
      note: note,
      onPressedDelete: () {
        cubit.deleteNote(note.id, note.image);
      },
      onTapNote: () {
       
        Navigator.pushNamed(context, Routes.noteDetailsRoute,
            arguments: note.toJson());
      },
    );
  }
}



import 'package:flutter/material.dart';

import 'package:fullnoteapp/presentation/resources/color_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../domain/models/models.dart';

import '../../resources/route_manager.dart';

import '../viewmodel/home_viewmodel.dart';
import 'widgets/fab.dart';
import 'widgets/note_item.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();
  final AppPreferences appPreferences = instance<AppPreferences>();


 

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();

    super.initState();
  }

  @override
  void dispose() {
 
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deepPurple,
      appBar: buildHomeAppBar(context),
      body: buildHomeBody(),
      floatingActionButton: Fab(viewModel:_viewModel),
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
              appPreferences.logout();
              Navigator.pushReplacementNamed(context, Routes.loginRoute);
            },
            icon: const Icon(Icons.power_settings_new_outlined))
      ],
    );
  }



  buildHomeBody() {
    return StreamBuilder<HomeViewObject>(
        stream: _viewModel.outputHomeViewObject,
        builder: (context, snapshot) {
          if (snapshot.data?.notes.isEmpty ?? true) {
            return const Center(
                child: Text(
              'There isn\'t any note yet',
              style: TextStyle(color: AppColor.white, fontSize: 25),
            ));
          } else {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
  }

  NoteItem buildNoteItem(
      Color backgroundColor, Note note, BuildContext context) {
    return NoteItem(
      backgroundColor: backgroundColor,
      note: note,
      onPressedDelete: () {
        _viewModel.deleteNote(note.id);
      },
      onTapNote: () {
        Navigator.pushNamed(context, Routes.noteDetailsRoute,
            arguments: note.toJson());
      },
    );
  }

 

  
}

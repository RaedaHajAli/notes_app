import 'package:flutter/material.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../../domain/models/models.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/images_manager.dart';
import '../../../resources/route_manager.dart';
import '../../cubit/home_cubit.dart';
import '../../viewmodel/home_viewmodel.dart';

class NoteItem extends StatelessWidget {
  const NoteItem(
      {super.key,
      required this.backgroundColor,
      required this.note,
      required this.onPressedDelete,
      required this.onTapNote
      });

  final Color backgroundColor;
  final Note note;
  final void Function()? onPressedDelete;
  final void Function()? onTapNote;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTapNote,
        
     
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            decoration: BoxDecoration(
                color: backgroundColor, borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Image.asset(
                    AppImages.logo,
                    height: 130,
                    width: 130,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        note.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          IconButton(
              onPressed: onPressedDelete,
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: AppColor.pink,
                size: 30,
              ))
        ],
      ),
    );
  }
}

class AddFab extends StatelessWidget {
  const AddFab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColor.pink,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {
        print('Add new note');
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}

 AppBar buildHomeAppBar(BuildContext context) {
    final AppPreferences appPreferences = instance<AppPreferences>();
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

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
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
                    children: List.generate(snapshot.data!.notes.length,
                        (index) {
                      Color backgroundColor = AppColor
                          .notesColor[index % AppColor.notesColor.length];

                      return buildNoteItem(backgroundColor, snapshot, index, context);
                    })));
          }
        });
  }

  NoteItem buildNoteItem(Color backgroundColor, AsyncSnapshot<HomeViewObject> snapshot, int index, BuildContext context) {
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
  }
}

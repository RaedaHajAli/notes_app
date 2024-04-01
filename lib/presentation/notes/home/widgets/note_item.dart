import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/app/constants.dart';
import 'package:fullnoteapp/presentation/notes/cubit/note_cubit.dart';
import 'package:fullnoteapp/presentation/notes/cubit/note_states.dart';
import 'package:fullnoteapp/presentation/resources/images_manager.dart';
import 'package:fullnoteapp/presentation/resources/strings_manager.dart';

import '../../../../../domain/models/models.dart';
import '../../../resources/color_manager.dart';

class NoteItem extends StatelessWidget {
  const NoteItem(
      {super.key,
      required this.backgroundColor,
      required this.note,
      required this.onPressedDelete,
      required this.onTapNote});

  final Color backgroundColor;
  final Note note;
  final void Function()? onPressedDelete;
  final void Function()? onTapNote;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapNote,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          BlocBuilder<NoteCubit, NoteStates>(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        note.image != AppStrings.logo
                            ? Image.network(
                                '${Constants.imageUrl}/${note.image}',
                                // convertStringToUint8List(note.image),
                                height: 130,
                                width: 130,
                              )
                            : Image.asset(AppImages.logo,
                            height: 130,
                                width: 130,
                            ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: Text(
                        note.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              );
            },
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

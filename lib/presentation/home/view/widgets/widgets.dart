import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/images_manager.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.backgroundColor,
    required this.note,
    required this.onPressed
  });

  final Color backgroundColor;
  final Note note;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            onPressed: onPressed,
            icon: const Icon(
              Icons.delete_forever_rounded,
              color: AppColor.pink,
              size: 30,
            ))
      ],
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

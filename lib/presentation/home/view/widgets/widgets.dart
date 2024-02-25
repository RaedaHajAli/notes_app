import 'package:flutter/material.dart';

import '../../../resources/images_manager.dart';
class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.backgroundColor,
  });

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Image.asset(
              AppImages.logo,
              height: 130,
              width: 130,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              'Title of the Note',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
          )
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

         child:  const Padding(
           padding: EdgeInsets.all(8.0),
           child: Icon(
            Icons.add,
            size: 30,
                   ),
         ),
        );
  }
}



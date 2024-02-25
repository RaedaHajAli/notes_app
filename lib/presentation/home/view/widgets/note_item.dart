import 'package:flutter/material.dart';

import '../../../resources/images_manager.dart';
import 'left_right_container.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: leftEditIcon,
      secondaryBackground: rightDeleteIcon,
      key: UniqueKey(),
      onDismissed: (direction) {
         print('delete');
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          //Go to bottom sheet if direction is start to end
          print('edit');

          return false;
        } else {
          //Delelte task if direction is end to start with delay
          return Future.delayed(const Duration(seconds: 1),
              () => direction == DismissDirection.endToStart);
        }
      },
      child: Container(
        width: double.infinity,
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.logo,
              width: 100,
              height: 100,
            ),
            const SizedBox(
              width: 5,
            ),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Note title',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      'Note content go to gym on saturday Note content go to gym on saturday  Note content go to gym on saturday Note content go to gym on saturday Note content go to gym on saturday Note content go to gym on saturday ',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

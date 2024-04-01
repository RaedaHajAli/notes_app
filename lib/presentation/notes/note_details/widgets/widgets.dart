// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../app/constants.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/images_manager.dart';
import '../../../resources/strings_manager.dart';

buildNoteImage(File? newImage, Map<String, dynamic>? note) {
  if (newImage == null) {
    //then check if there a specific image of note
    if (note!['image'] != AppStrings.logo) {
      //if no => get image from server
      return Image.network(
        '${Constants.imageUrl}/${note['image']}',
        height: 120,
        fit: BoxFit.cover,
      );
    }
    // else view logo image from asset
    else {
      return Image.asset(
        AppImages.logo,
        height: 120,
      );
    }
  } else {
    return Image.file(
      newImage,
      height: 120,
      fit: BoxFit.cover,
    );
  }
}

class PickImage extends StatelessWidget {
  const PickImage({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      //  () async {
      //   newImage =
      //       await cubit.pickImageFromGallery();
      // },
      child: Container(
          padding: const EdgeInsets.all(5),
          decoration:
              BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
          child: const Icon(
            Icons.edit,
            color: AppColor.green,
          )),
    );
  }
}

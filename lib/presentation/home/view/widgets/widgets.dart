import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/presentation/home/cubit/home_state.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../../domain/models/models.dart';
import '../../../common/widgets/widgets.dart';
import '../../../note_details/view/widgets/widgets.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/images_manager.dart';
import '../../../resources/route_manager.dart';

import '../../cubit/home_cubit.dart';

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
          Container(
            decoration: BoxDecoration(
                color: backgroundColor, borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.logo,
                     // convertStringToUint8List(note.image),
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

convertStringToUint8List(String imageString) {
  
  Uint8List bytesImage = Base64Decoder().convert(imageString);
  return bytesImage;


}

class AddFab extends StatefulWidget {
  const AddFab({
    super.key,
  });

  @override
  State<AddFab> createState() => _AddFabState();
}

class _AddFabState extends State<AddFab> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  late HomeCubit cubit;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<HomeCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColor.pink,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            builder: (context) {
              return BlocBuilder<HomeCubit, HomeStates>(
                builder: (context, state) {
                  return Container(
                    height: 600,
                    child: Form(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 25,
                          right: 10,
                          left: 10,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              StreamBuilder<String?>(
                                  stream: cubit.homeViewModel.outputErrorTitle,
                                  builder: (context, snapshot) {
                                    return NoteTextFormField(
                                        titleController: titleController,
                                        hint: 'Title',
                                        errorText: snapshot.data,
                                        onChanged: (title) {
                                          cubit.homeViewModel.setTitle(title);
                                        });
                                  }),
                              const SizedBox(
                                height: 12,
                              ),
                              StreamBuilder<String?>(
                                  stream:
                                      cubit.homeViewModel.outputErrorContent,
                                  builder: (context, snapshot) {
                                    return NoteTextFormField(
                                        titleController: contentController,
                                        hint: 'Add your title content...',
                                        maxLines: 10,
                                        errorText: snapshot.data,
                                        onChanged: (content) {
                                          cubit.homeViewModel
                                              .setContent(content);
                                        });
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.image_outlined,
                                      color: AppColor.mediumPurple),
                                  TextButton(
                                      onPressed: () {
                                        cubit.pickImageFromGallery();
                                      },
                                      child: const Text(
                                        'Add Image',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColor.mediumPurple),
                                      )),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 25,
                                    ),
                                    child: StreamBuilder<File>(
                                        stream:
                                            cubit.homeViewModel.outputNoteImage,
                                        builder: (context, snapshot) {
                                          return _imagePickedByUser(
                                              snapshot.data);
                                        }),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              StreamBuilder<bool>(
                                  stream: cubit
                                      .homeViewModel.outputAreAllInputsValid,
                                  builder: (context, snapshot) {
                                    return buildCustomButton(
                                        title: 'Add',
                                        textColor: AppColor.white,
                                        backgroundColor: AppColor.pink,
                                        onPressed: (snapshot.data ?? false)
                                            ? () {
                                                cubit.addNote();

                                                titleController.clear();
                                                contentController.clear();

                                                Navigator.pop(context);
                                              }
                                            : null);
                                  }),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            });
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

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      //return image
      return Image.file(
        image,
        height: 40,
        width: 40,
      );
    } else {
      return Image.asset(
        AppImages.logo,
        height: 40,
        width: 40,
      );
    }
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

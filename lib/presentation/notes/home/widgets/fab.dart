//Fab

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/presentation/common/freezed_data_classes.dart';
import 'package:fullnoteapp/presentation/notes/cubit/note_states.dart';

import '../../../common/widgets/widgets.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/images_manager.dart';
import '../../cubit/note_cubit.dart';

class Fab extends StatefulWidget {
  const Fab({super.key});

  @override
  State<Fab> createState() => _FabState();
}

class _FabState extends State<Fab> {
  late NoteCubit cubit;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.always;

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.clear();
    _contentController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColor.pink,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {
        buildModalBottomSheet(context);
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

// Bottom Sheet
  Future<dynamic> buildModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        builder: (context) {
          return Container(
            height: 600,
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  right: 10,
                  left: 10,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      NoteTextFormField(
                        titleController: _titleController,
                        hint: 'Title',
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      NoteTextFormField(
                        titleController: _contentController,
                        hint: 'Add your note content...',
                        maxLines: 10,
                      ),
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
                                    fontSize: 18, color: AppColor.mediumPurple),
                              )),
                          const Spacer(),
                          BlocBuilder<NoteCubit, NoteStates>(
                            builder: (context, state) {
                              return Padding(
                                  padding: const EdgeInsets.only(
                                    right: 25,
                                  ),
                                  child: cubit.noteImage != null &&
                                          cubit.noteImage!.path.isNotEmpty
                                      ? Image.file(
                                          cubit.noteImage!,
                                          height: 40,
                                          width: 40,
                                        )
                                      : Image.asset(
                                          AppImages.logo,
                                          height: 40,
                                          width: 40,
                                        ));
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      buildCustomButton(
                          title: 'Add',
                          textColor: AppColor.white,
                          backgroundColor: AppColor.pink,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (cubit.noteImage != null) {
                                cubit
                                    .add(AddNoteWithImageObject(
                                        _titleController.text,
                                        _contentController.text,
                                        cubit.noteImage))
                                    .then((_) {
                                  _titleController.text = '';
                                  _contentController.text = '';
                                  cubit.noteImage = null;
                                  Navigator.pop(context);
                                });
                              } else {
                                cubit
                                    .add(AddNoteWithImageObject(
                                        _titleController.text,
                                        _contentController.text,
                                        null))
                                    .then((_) {
                                  _titleController.text = '';
                                  _contentController.text = '';

                                  Navigator.pop(context);
                                });
                              }
                            }
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
        });
  }
}

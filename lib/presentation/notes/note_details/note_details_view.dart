import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/presentation/common/freezed_data_classes.dart';

import 'package:fullnoteapp/presentation/notes/cubit/note_states.dart';

import 'package:fullnoteapp/presentation/resources/color_manager.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


import '../../common/widgets/widgets.dart';
import '../../resources/strings_manager.dart';
import '../cubit/note_cubit.dart';
import 'widgets/widgets.dart';

class NoteDetailsView extends StatefulWidget {
  const NoteDetailsView({
    super.key,
    required this.note,
  });
  final Map<String, dynamic>? note;

  @override
  State<NoteDetailsView> createState() => _NoteDetailsViewState();
}

class _NoteDetailsViewState extends State<NoteDetailsView> {
  late NoteCubit cubit;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.always;
  File? newImage;

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    if (widget.note != null) {
      titleController.text = widget.note?['title'];
      contentController.text = widget.note?['content'];
    }

    super.initState();
  }

  @override
  void dispose() {
    titleController.clear();
    contentController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deepPurple,
      body: _getContentWidget(),
      appBar: AppBar(
        backgroundColor: AppColor.deepPurple,
        elevation: 0,
      ),
    );
  }

  Widget _getContentWidget() {
    return widget.note == null
        ? const Center(
            child: Text(
            AppStrings.someThingWentWrong,
            style: TextStyle(color: AppColor.white),
          ))
        : Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 8),
            child: BlocBuilder<NoteCubit, NoteStates>(
              builder: (context, state) {
                return ModalProgressHUD(
                  inAsyncCall: cubit.inAsyncCallDetails,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                buildNoteImage(newImage, widget.note),
                               
                                PickImage(onTap: () async {
                                  newImage = await cubit.pickImageFromGallery();
                                })
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Form(
                              key: formKey,
                              autovalidateMode: autovalidateMode,
                              child: Column(
                                children: [
                                  NoteTextFormField(
                                    titleController: titleController,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  NoteTextFormField(
                                    titleController: contentController,
                                    maxLines: 10,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 100),
                                    child: CustomButton(
                                        title: AppStrings.save,
                                        textColor: AppColor.white,
                                        backgroundColor: AppColor.pink,
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            bool isSame = widget
                                                        .note!['title'] ==
                                                    titleController.text &&
                                                widget.note!['content'] ==
                                                    contentController.text &&
                                                newImage == null;
                                            if (!isSame) {
                                              cubit
                                                  .editNote(EditNoteObject(
                                                      widget.note!['id'],
                                                      titleController.text,
                                                      contentController.text,
                                                      widget.note!['image'],
                                                      newImage))
                                                  .then((value) =>
                                                      Navigator.pop(context));
                                            }
                                          }
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}

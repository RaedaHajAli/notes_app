import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullnoteapp/presentation/common/freezed_data_classes.dart';

import 'package:fullnoteapp/presentation/resources/color_manager.dart';
import 'package:fullnoteapp/presentation/resources/images_manager.dart';

import '../../common/widgets/widgets.dart';
import '../cubit/note_cubit.dart';

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
        backgroundColor: AppColor.deepPurple, body: _getContentWidget());
  }

  Widget _getContentWidget() {
    return widget.note == null
        ? const Center(
            child: Text(
            'Something went wrong ',
            style: TextStyle(color: AppColor.white),
          ))
        : Padding(
            padding:
                const EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 8),
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
                          Image.asset(
                            AppImages.logo,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.edit,
                                color: AppColor.green,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                        key: formKey,
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
                              child: buildCustomButton(
                                  title: 'Save',
                                  textColor: AppColor.white,
                                  backgroundColor: AppColor.pink,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit
                                          .editNote(EditNoteObject(
                                              widget.note!['id'],
                                              titleController.text,
                                              contentController.text,
                                              widget.note!['image']))
                                          .then((_) {
                                        Navigator.pop(context);
                                      });
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
  }
}

import 'package:flutter/material.dart';
import 'package:fullnoteapp/presentation/auth/widgets.dart';

import 'package:fullnoteapp/presentation/resources/color_manager.dart';
import 'package:fullnoteapp/presentation/resources/images_manager.dart';

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
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  @override
  void dispose() {
    titleController.clear();
    contentController.clear();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.note != null) {
      titleController.text = widget.note?['title'];
      contentController.text = widget.note?['content'];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deepPurple,
      body: widget.note == null
          ? const Center(
              child: Text(
              'Something went wrong ',
              style: TextStyle(color: AppColor.white),
            ))
          : Padding(
              padding: const EdgeInsets.only(
                  top: 80, left: 20, right: 20, bottom: 8),
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
                        child: Image.asset(
                          AppImages.logo,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Form(
                          child: Column(
                            children: [
                              DetailsTextFormField(
                                  titleController: titleController),
                              const SizedBox(
                                height: 12,
                              ),
                              DetailsTextFormField(
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
                                      print('save');
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
            ),
    );
  }
}


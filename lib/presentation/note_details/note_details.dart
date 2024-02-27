import 'package:flutter/material.dart';

import 'package:fullnoteapp/presentation/resources/color_manager.dart';
import 'package:fullnoteapp/presentation/resources/images_manager.dart';

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
              padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Image.asset(
                        AppImages.logo,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                    ),
                    TextFormField(
                      controller: contentController,
                      keyboardType: TextInputType.text,
                      maxLines: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

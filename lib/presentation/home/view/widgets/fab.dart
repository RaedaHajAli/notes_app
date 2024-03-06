//Fab
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widgets/widgets.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/images_manager.dart';
import '../../viewmodel/home_viewmodel.dart';

class Fab extends StatefulWidget {
  const Fab({super.key, required this.viewModel});
  final HomeViewModel viewModel;

  @override
  State<Fab> createState() => _FabState();
}

class _FabState extends State<Fab> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  ImagePicker picker = ImagePicker();

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
                          stream: widget.viewModel.outputErrorTitle,
                          builder: (context, snapshot) {
                        
                            return NoteTextFormField(
                                titleController: _titleController,
                                hint: 'Title',
                                errorText: snapshot.data,
                                onChanged: (title) {
                                  widget.viewModel.setTitle(title);
                                });
                          }),
                      const SizedBox(
                        height: 12,
                      ),
                      StreamBuilder<String?>(
                          stream: widget.viewModel.outputErrorContent,
                          builder: (context, snapshot) {
                            return NoteTextFormField(
                                titleController: _contentController,
                                hint: 'Add your title content...',
                                maxLines: 10,
                                errorText: snapshot.data,
                                onChanged: (content) {
                                  widget.viewModel.setContent(content);
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
                                pickImageFromGallery();
                              },
                              child: const Text(
                                'Add Image',
                                style: TextStyle(
                                    fontSize: 18, color: AppColor.mediumPurple),
                              )),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 25,
                            ),
                            child: StreamBuilder<File>(
                                stream: widget.viewModel.outputNoteImage,
                                builder: (context, snapshot) {
                                  return _imagePickedByUser(snapshot.data);
                                }),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      StreamBuilder<bool>(
                          stream: widget.viewModel.outputAreAllInputsValid,
                          builder: (context, snapshot) {
                            return buildCustomButton(
                                title: 'Add',
                                textColor: AppColor.white,
                                backgroundColor: AppColor.pink,
                                onPressed: (snapshot.data ?? false)
                                    ? () {
                                        widget.viewModel.addNote();

                                        _titleController.clear();
                                        _contentController.clear();

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
        });
  }

//Pick Image
  pickImageFromCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    widget.viewModel.setNoteImage(File(image?.path ?? ''));
  }

  pickImageFromGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    widget.viewModel.setNoteImage(File(image?.path ?? ''));
  }

//Note Image Widget
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

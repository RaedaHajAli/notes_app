import 'dart:io';

import 'package:flutter/material.dart';


import 'package:fullnoteapp/presentation/resources/color_manager.dart';

import '../../../app/di.dart';
import '../../../domain/models/models.dart';
import '../../common/widgets/widgets.dart';
import '../../note_details/view/widgets/widgets.dart';
import '../../resources/images_manager.dart';
import '../../resources/route_manager.dart';

import '../viewmodel/home_viewmodel.dart';
import 'widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel _viewModel = instance<HomeViewModel>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  ImagePicker picker = ImagePicker();

  pickImageFromCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    _viewModel.setNoteImage(File(image?.path ?? ''));
  }

  pickImageFromGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    _viewModel.setNoteImage(File(image?.path ?? ''));
  }

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();

    super.initState();
  }

  @override
  void dispose() {
    _titleController.clear();
    _contentController.clear();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deepPurple,
      appBar: buildHomeAppBar(context),
      body: buildHomeBody(),
      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }

  Future<dynamic> buildModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
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
                              stream: _viewModel.outputErrorTitle,
                              builder: (context, snapshot) {
                                //todo move this widget to base
                                return NoteTextFormField(
                                    titleController: _titleController,
                                    hint: 'Title',
                                    errorText: snapshot.data,
                                    onChanged: (title) {
                                      _viewModel.setTitle(title);
                                    });
                              }),
                          const SizedBox(
                            height: 12,
                          ),
                          StreamBuilder<String?>(
                              stream: _viewModel.outputErrorContent,
                              builder: (context, snapshot) {
                                return NoteTextFormField(
                                    titleController: _contentController,
                                    hint: 'Add your title content...',
                                    maxLines: 10,
                                    errorText: snapshot.data,
                                    onChanged: (content) {
                                      _viewModel.setContent(content);
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
                                        fontSize: 18,
                                        color: AppColor.mediumPurple),
                                  )),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 25,
                                ),
                                child: StreamBuilder<File>(
                                    stream: _viewModel.outputNoteImage,
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
                              stream: _viewModel.outputAreAllInputsValid,
                              builder: (context, snapshot) {
                                return buildCustomButton(
                                    title: 'Add',
                                    textColor: AppColor.white,
                                    backgroundColor: AppColor.pink,
                                    onPressed: (snapshot.data ?? false)
                                        ? () {
                                            _viewModel.addNote();

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

  buildHomeBody() {
    return StreamBuilder<HomeViewObject>(
        stream: _viewModel.outputHomeViewObject,
        builder: (context, snapshot) {
          if (snapshot.data?.notes.isEmpty ?? true) {
            return const Center(
                child: Text(
              'There isn\'t any note yet',
              style: TextStyle(color: AppColor.white, fontSize: 25),
            ));
          } else {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: GridView.count(
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children:
                        List.generate(snapshot.data!.notes.length, (index) {
                      Color backgroundColor = AppColor
                          .notesColor[index % AppColor.notesColor.length];

                      return buildNoteItem(backgroundColor,
                          snapshot.data!.notes[index], context);
                    })));
          }
        });
  }

  NoteItem buildNoteItem(
      Color backgroundColor, Note note, BuildContext context) {
    return NoteItem(
      backgroundColor: backgroundColor,
      note: note,
      onPressedDelete: () {
        _viewModel.deleteNote(note.id);
      },
      onTapNote: () {
        Navigator.pushNamed(context, Routes.noteDetailsRoute,
            arguments: note.toJson());
      },
    );
  }
}

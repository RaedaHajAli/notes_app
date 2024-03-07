import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fullnoteapp/presentation/notes/note_details/viewmodel/note_details_viewmodel.dart';

import 'package:fullnoteapp/presentation/resources/color_manager.dart';
import 'package:fullnoteapp/presentation/resources/images_manager.dart';
import 'package:fullnoteapp/presentation/resources/route_manager.dart';

import '../../../../app/di.dart';
import '../../../common/widgets/widgets.dart';

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
  NoteDetailsViewModel _viewModel = instance<NoteDetailsViewModel>();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  _bind() {
    _viewModel.start();
    titleController.addListener(() {
      _viewModel.setTitle(titleController.text, widget.note?['title']);
    });
    contentController.addListener(() {
      _viewModel.setContent(contentController.text, widget.note?['content']);
    });
  }

  @override
  void initState() {
    _bind();
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
    _viewModel.dispose();
    super.dispose();
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
                        child: StreamBuilder<File>(
                            stream: _viewModel.outputNoteImage,
                            builder: (context, snapshot) {
                              return Stack(
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
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Form(
                          child: Column(
                            children: [
                              StreamBuilder<String?>(
                                  stream: _viewModel.outputErrorTitle,
                                  builder: (context, snapshot) {
                                    return NoteTextFormField(
                                      titleController: titleController,
                                      errorText: snapshot.data,
                                    );
                                  }),
                              const SizedBox(
                                height: 12,
                              ),
                              StreamBuilder<String?>(
                                  stream: _viewModel.outputErrorContent,
                                  builder: (context, snapshot) {
                                    return NoteTextFormField(
                                      titleController: contentController,
                                      maxLines: 10,
                                      errorText: snapshot.data,
                                    );
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 100),
                                child: StreamBuilder<bool>(
                                    stream: _viewModel.outputAreAllInputsValid,
                                    builder: (context, snapshot) {
                                      return buildCustomButton(
                                          title: 'Save',
                                          textColor: AppColor.white,
                                          backgroundColor: AppColor.pink,
                                          onPressed: (snapshot.data ?? false)
                                              ? () {
                                                  print('save');
                                                  _viewModel
                                                      .editNote(
                                                          widget.note?['id'])
                                                      .then((_) {
                                                    Navigator.pushNamedAndRemoveUntil(context, Routes.homeRoute, (route) => false);
                                                    
                                                  });
                                                }
                                              : null);
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

import 'dart:async';
import 'dart:io';

import 'package:fullnoteapp/domain/usecase/edit_note_usecase.dart';
import 'package:fullnoteapp/presentation/base/base_viewmodel.dart';
import 'package:fullnoteapp/presentation/common/freezed_data_classes.dart';

import '../../../app/functions.dart';
import '../../resources/strings_manager.dart';

class NoteDetailsViewModel extends BaseViewModel
    with NoteDetailsViewModelInputs, NoteDetailsViewModelOutputs {
  final StreamController _titleStreamController =
      StreamController<String>.broadcast();
  final StreamController _contentStreamController =
      StreamController<String>.broadcast();
  final StreamController _imageStreamController =
      StreamController<File>.broadcast();
  final StreamController _allInputsStreamController =
      StreamController<void>.broadcast();

  final EditNoteUseCase _editNoteUseCase;
  NoteDetailsViewModel(this._editNoteUseCase);

  EditNoteObject editNoteObject = EditNoteObject('', '', '');

  @override
  void start() {
    super.start();
  }

  @override
  void dispose() {
    _titleStreamController.close();
    _contentStreamController.close();
    _imageStreamController.close();
    _allInputsStreamController.close();

    super.dispose();
  }

  //inputs
  @override
  editNote(int noteId) async {
    (await _editNoteUseCase.execute(EditNoteUseCaseInput(
      noteId: noteId,
      title: editNoteObject.title,
      content: editNoteObject.content,
      // image:
      //     convertImageFileToString(File(editNoteObject.imagePath)) ?? 'image',
    )))
        .fold((failure) {
      print(failure.message);
    }, (operationStatus) {
      print(operationStatus.message);
    });
  }

  @override
  setContent(String content, String previousContent) {
    inputContent.add(content);
    if (isFieldValid(content)) {
      editNoteObject = editNoteObject.copyWith(content: content);
    } else {
      editNoteObject = editNoteObject.copyWith(content: previousContent);
    }
    _validate();
  }

  @override
  setNoteImage(File noteImage) {
    inputNoteImage.add(noteImage);
    if (noteImage.path.isNotEmpty) {
      editNoteObject = editNoteObject.copyWith(imagePath: noteImage.path);
    } else {
      editNoteObject = editNoteObject.copyWith(imagePath: '');
    }
    _validate();
  }

  @override
  setTitle(String title,String previousTitle) {
    inputTitle.add(title);
    if (isFieldValid(title)) {
      editNoteObject = editNoteObject.copyWith(title: title);
    } else {
      editNoteObject = editNoteObject.copyWith(title: previousTitle);
    }
    _validate();
  }

  @override
  Sink get inputAllInputsValid => _allInputsStreamController.sink;

  @override
  Sink get inputContent => _contentStreamController.sink;

  @override
  Sink get inputNoteImage => _imageStreamController.sink;

  @override
  Sink get inputTitle => _titleStreamController.sink;

  @override
  Stream<bool> get outputIsContentValid =>
      _contentStreamController.stream.map((content) => isFieldValid(content));
  @override
  Stream<String?> get outputErrorContent => outputIsContentValid
      .map((isContentValid) => isContentValid ? null : AppStrings.fieldError);

  @override
  Stream<bool> get outputIsTitleValid =>
      _titleStreamController.stream.map((title) => isFieldValid(title));

  @override
  Stream<String?> get outputErrorTitle => outputIsTitleValid
      .map((isTitleValid) => isTitleValid ? null : AppStrings.fieldError);

  @override
  Stream<File> get outputNoteImage =>
      _imageStreamController.stream.map((noteImage) => noteImage);

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _allInputsStreamController.stream.map((_) => _areAllInputsValid());

  //private functions

  bool _areAllInputsValid() {
    return editNoteObject.title.isNotEmpty && editNoteObject.content.isNotEmpty;
    // editNoteObject.imagePath.isNotEmpty;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }
}

mixin NoteDetailsViewModelInputs {
  setTitle(String title,String previousTitle);
  setContent(String content, String previousContent);
  setNoteImage(File noteImage);
  editNote(int noteId);
  Sink get inputTitle;
  Sink get inputContent;
  Sink get inputNoteImage;
  Sink get inputAllInputsValid;
}

mixin NoteDetailsViewModelOutputs {
  Stream<bool> get outputIsTitleValid;
  Stream<String?> get outputErrorTitle;
  Stream<bool> get outputIsContentValid;
  Stream<String?> get outputErrorContent;
  Stream<File> get outputNoteImage;
  Stream<bool> get outputAreAllInputsValid;
}

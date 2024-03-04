// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fullnoteapp/app/app_prefs.dart';
import 'package:fullnoteapp/domain/usecase/add_note_usecase.dart';
import 'package:fullnoteapp/domain/usecase/delete_note_usecase.dart';
import 'package:fullnoteapp/domain/usecase/view_note_usecase.dart';
import 'package:fullnoteapp/presentation/base/base_viewmodel.dart';
import 'package:fullnoteapp/presentation/common/freezed_data_classes.dart';
import 'package:fullnoteapp/presentation/resources/strings_manager.dart';

import '../../../domain/models/models.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final ViewNoteUseCase _viewNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;
  final AddNoteUseCase _addNoteUseCase;
  final AppPreferences _appPreferences;
  final StreamController _homeViewObjectStreamController =
      BehaviorSubject<HomeViewObject>();
  final StreamController _titleStreamController =
      StreamController<String>.broadcast();
  final StreamController _contentStreamController =
      StreamController<String>.broadcast();
  final StreamController _imageStreamController =
      StreamController<File>.broadcast();
  final StreamController _allInputsStreamController =
      StreamController<void>.broadcast();

  AddNoteObject addNoteObject = AddNoteObject('', '', '');

  HomeViewModel(
    this._viewNoteUseCase,
    this._deleteNoteUseCase,
    this._addNoteUseCase,
    this._appPreferences,
  );
  int? userId;

  @override
  void start() {
    getNotes();
    super.start();
  }

  @override
  void dispose() {
    _homeViewObjectStreamController.close();
    _titleStreamController.close();
    _contentStreamController.close();
    _imageStreamController.close();
    _allInputsStreamController.close();

    super.dispose();
  }

//inputs
  @override
  getNotes() async {
    _getUserId();

    if (userId != null) {
      (await _viewNoteUseCase.execute(ViewNoteUseCaseInput(userId: userId!)))
          .fold((failure) {
        print(failure.message);
      }, (data) {
        inputHomeViewObject.add(HomeViewObject(notes: data.notes));
      });
    } else {
      print(' No user id found');
    }
  }

  @override
  deleteNote(int noteId) async {
    (await _deleteNoteUseCase.execute(DeleteNoteUseCaseInput(noteId: noteId)))
        .fold((failure) {
      print(failure.message);
    }, (operationStatus) {
      print(operationStatus.message);
    });
    getNotes();
  }

  @override
  addNote() async {
    (await _addNoteUseCase.execute(AddNoteUseCaseInput(
            title: addNoteObject.title,
            content: addNoteObject.content,
            image: _convertImage(File(addNoteObject.imagePath)) ?? 'image',
            userId: userId!)))
        .fold((failure) {
      print(failure.message);
    }, (data) {
      print(data.message);
      _clearFields();
      getNotes();
    });
  }

  @override
  Sink get inputHomeViewObject => _homeViewObjectStreamController.sink;
  @override
  Sink get inputAllInputsValid => _allInputsStreamController.sink;

  @override
  Sink get inputContent => _contentStreamController.sink;

  @override
  Sink get inputTitle => _titleStreamController.sink;

  @override
  setContent(String content) {
    inputContent.add(content);
    if (_isFieldValid(content)) {
      addNoteObject = addNoteObject.copyWith(content: content);
    } else {
      addNoteObject = addNoteObject.copyWith(content: '');
    }
    _validate();
  }

  @override
  setTitle(String title) {
    inputTitle.add(title);
    if (_isFieldValid(title)) {
      addNoteObject = addNoteObject.copyWith(title: title);
    } else {
      addNoteObject = addNoteObject.copyWith(title: '');
    }
    _validate();
  }

  @override
  setNoteImage(File noteImage) {
    inputNoteImage.add(noteImage);
    if (noteImage.path.isNotEmpty) {
      addNoteObject = addNoteObject.copyWith(imagePath: noteImage.path);
    } else {
      addNoteObject = addNoteObject.copyWith(imagePath: '');
    }
    _validate();
  }

  @override
  Sink get inputNoteImage => _imageStreamController.sink;

//outputs
  @override
  Stream<HomeViewObject> get outputHomeViewObject =>
      _homeViewObjectStreamController.stream
          .map((homeViewObject) => homeViewObject);
  @override
  Stream<bool> get outputIsTitleValid =>
      _titleStreamController.stream.map((title) => _isFieldValid(title));
  @override
  Stream<String?> get outputErrorTitle => outputIsTitleValid
      .map((isTitleValid) => isTitleValid ? null : AppStrings.fieldError);

  @override
  Stream<bool> get outputIsContentValid =>
      _contentStreamController.stream.map((content) => _isFieldValid(content));
  @override
  Stream<String?> get outputErrorContent => outputIsContentValid
      .map((isContentValid) => isContentValid ? null : AppStrings.fieldError);

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _allInputsStreamController.stream.map((_) => _areAllInputsValid());

  @override
  Stream<File> get outputNoteImage =>
      _imageStreamController.stream.map((noteImage) => noteImage);
  //private functions
  bool _isFieldValid(String text) {
    return text.length >= 5;
  }

  bool _areAllInputsValid() {
    return addNoteObject.content.isNotEmpty &&
        addNoteObject.title.isNotEmpty &&
        addNoteObject.imagePath.isNotEmpty;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }

  _getUserId() {
    User? user = _appPreferences.getUserData();
    if (user != null) {
      userId = user.id;
    }
  }

  _convertImage(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  _clearFields() {
  addNoteObject = addNoteObject.copyWith(title: '', content:'',imagePath: '');
  }
}

mixin HomeViewModelInputs {
  setTitle(String title);
  setContent(String content);
  setNoteImage(File noteImage);
  addNote();
  getNotes();
  deleteNote(int noteId);
  Sink get inputHomeViewObject;
  Sink get inputTitle;
  Sink get inputContent;
  Sink get inputNoteImage;
  Sink get inputAllInputsValid;
}

mixin HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeViewObject;
  Stream<bool> get outputIsTitleValid;
  Stream<String?> get outputErrorTitle;
  Stream<bool> get outputIsContentValid;
  Stream<String?> get outputErrorContent;
  Stream<File> get outputNoteImage;
  Stream<bool> get outputAreAllInputsValid;
}

class HomeViewObject {
  List<Note> notes;
  HomeViewObject({
    required this.notes,
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fullnoteapp/presentation/common/freezed_data_classes.dart';

import 'package:fullnoteapp/presentation/notes/cubit/note_states.dart';

import '../../../app/app_prefs.dart';

import '../../../domain/models/models.dart';
import '../../../domain/usecase/add_note_usecase.dart';
import '../../../domain/usecase/delete_note_usecase.dart';
import '../../../domain/usecase/edit_note_usecase.dart';
import '../../../domain/usecase/view_note_usecase.dart';
import 'package:image_picker/image_picker.dart';

class NoteCubit extends Cubit<NoteStates> {
  NoteCubit(
    this._viewNoteUseCase,
    this._deleteNoteUseCase,
    this._addNoteUseCase,
    this._editNoteUseCase,
    this._appPreferences,
  ) : super(InitialNoteState());
  final ViewNoteUseCase _viewNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;
  final AddNoteUseCase _addNoteUseCase;

  final EditNoteUseCase _editNoteUseCase;
  final AppPreferences _appPreferences;

  int? userId;

  User? user;

  List<Note> notes = [];

  _getUserId() {
    user = _appPreferences.getUserData();
    if (user != null) {
      userId = user?.id;
    }
  }

  getNotes() async {
    notes = [];
    emit(LoadingGetNotesState());
    _getUserId();

    if (userId != null) {
      (await _viewNoteUseCase.execute(ViewNoteUseCaseInput(userId: userId!)))
          .fold((failure) {
        emit(FailureGetNotesState(message: failure.message));
      }, (data) {
        notes = data.notes;
        emit(SuccessGetNotesState());
      });
    } else {
      print(' No user id found');
    }
  }

  bool inAsyncCallHome = false;
  Future<void> add(AddNoteObject addNoteObject) async {
    inAsyncCallHome = true;
    emit(LoadingAddNoteState());
    (await _addNoteUseCase.execute(AddNoteUseCaseInput(
            title: addNoteObject.title,
            content: addNoteObject.content,
            image: addNoteObject.image,
            userId: userId!)))
        .fold((failure) {
      inAsyncCallHome = false;
      emit(FailureAddNoteState(message: failure.message));
      print(failure.message);
    }, (data) {
      inAsyncCallHome = false;
      emit(SuccessAddNoteState());

      getNotes();
    });
  }

  deleteNote(int noteId, String imageName) async {
    emit(LoadingDeleteNoteState());
    (await _deleteNoteUseCase.execute(
            DeleteNoteUseCaseInput(noteId: noteId, imageName: imageName)))
        .fold((failure) {
      emit(FailureDeleteNoteState());
    }, (operationStatus) {
      emit(SuccessDeleteNoteState());
      getNotes();
    });
  }

  bool inAsyncCallDetails = false;
  Future<void> editNote(EditNoteObject editNoteObject) async {
    inAsyncCallDetails = true;
    emit(LoadingEditNoteState());
    (await _editNoteUseCase.execute(EditNoteUseCaseInput(
            noteId: editNoteObject.id,
            title: editNoteObject.title,
            content: editNoteObject.content,
            imageName: editNoteObject.imageName,
            newImage: editNoteObject.newImage)))
        .fold((failure) {
          inAsyncCallDetails = false;
      emit(FailureEditNoteState());
    }, (operationStatus) {
      inAsyncCallDetails = false;
      emit(SuccessEditeNoteState());
      getNotes();
    });
  }

  ImagePicker picker = ImagePicker();

  //Pick Image
  pickImageFromCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      print(' **********${image.path}');
      emit(PickImageSuccessNoteState());
      return File(image.path);
    } else {
      emit(PickImageFailureNoteState());
      return null;
    }
  }

  Future<File?> pickImageFromGallery() async {
    File? file;
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      print(' **********${image.path}');

      file = File(image.path);
      emit(PickImageSuccessNoteState());
    } else {
      file = null;
      emit(PickImageFailureNoteState());
    }
    return file;
  }

  logout() {
    _appPreferences.logout();
  }
}

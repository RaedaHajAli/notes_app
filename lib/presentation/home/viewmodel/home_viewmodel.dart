// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:fullnoteapp/app/app_prefs.dart';
import 'package:fullnoteapp/domain/usecase/delete_note_usecase.dart';
import 'package:fullnoteapp/domain/usecase/view_note_usecase.dart';
import 'package:fullnoteapp/presentation/base/base_viewmodel.dart';

import '../../../domain/models/models.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final ViewNoteUseCase _viewNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;
  final AppPreferences _appPreferences;
  final StreamController _homeViewObjectStreamController =
      BehaviorSubject<HomeViewObject>();

  HomeViewModel(
      this._viewNoteUseCase, this._deleteNoteUseCase, this._appPreferences);
  int? userId;

  @override
  void start() {
    User? user = _appPreferences.getUserData();
    if (user != null) {
      userId = user.id;
      getNotes();
    }

    super.start();
  }

  @override
  void dispose() {
    _homeViewObjectStreamController.close();

    super.dispose();
  }

  getNotes() async {
    (await _viewNoteUseCase.execute(ViewNoteUseCaseInput(userId: userId!)))
        .fold((failure) {
      print(failure.message);
    }, (data) {
      inputHomeViewObject.add(HomeViewObject(notes: data.notes));
    });
  }

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
  Sink get inputHomeViewObject => _homeViewObjectStreamController.sink;

  @override
  Stream<HomeViewObject> get outputHomeViewObject =>
      _homeViewObjectStreamController.stream
          .map((homeViewObject) => homeViewObject);
}

mixin HomeViewModelInputs {
  Sink get inputHomeViewObject;
}

mixin HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeViewObject;
}

class HomeViewObject {
  List<Note> notes;
  HomeViewObject({
    required this.notes,
  });
}

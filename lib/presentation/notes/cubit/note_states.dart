// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class NoteStates {}

class InitialNoteState extends NoteStates {}

class LoadingGetNotesState extends NoteStates {}

class SuccessGetNotesState extends NoteStates {}

class FailureGetNotesState extends NoteStates {
  String message;
  FailureGetNotesState({
    required this.message,
  });
}

class LoadingAddNoteState extends NoteStates {}

class SuccessAddNoteState extends NoteStates {}

class FailureAddNoteState extends NoteStates {
   String message; 
  FailureAddNoteState({
    required this.message,
  });
}

class LoadingDeleteNoteState extends NoteStates {}

class SuccessDeleteNoteState extends NoteStates {}

class FailureDeleteNoteState extends NoteStates {}

class LoadingEditNoteState extends NoteStates {}

class SuccessEditeNoteState extends NoteStates {}

class FailureEditNoteState extends NoteStates {}

class PickImageSuccessNoteState extends NoteStates {}

class PickImageFailureNoteState extends NoteStates {}

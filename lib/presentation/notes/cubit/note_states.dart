abstract class NoteStates {}

class InitialNoteState extends NoteStates {}

class LoadingGetNotesState extends NoteStates {}

class SuccessGetNotesState extends NoteStates {}

class FailureGetNotesState extends NoteStates {}

class LoadingAddNoteState extends NoteStates {}

class SuccessAddNoteState extends NoteStates {}

class FailureAddNoteState extends NoteStates {}

class LoadingDeleteNoteState extends NoteStates {}

class SuccessDeleteNoteState extends NoteStates {}

class FailureDeleteNoteState extends NoteStates {}

class LoadingEditNoteState extends NoteStates {}

class SuccessEditeNoteState extends NoteStates {}

class FailureEditNoteState extends NoteStates {}

class PickImageSuccessNoteState extends NoteStates {}
class PickImageFailureNoteState extends NoteStates {}

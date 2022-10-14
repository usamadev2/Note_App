import 'package:notes_flutter/model/notes.dart';

class NoteState {}

class InitialNoteState extends NoteState {}

class LoadingNotesState extends NoteState {}

class LoadedNoteState extends NoteState {
  LoadedNoteState(this.notes);
  List<Notes> notes;
}

class ErrorNotesState extends NoteState {
  ErrorNotesState(this.message);
  String message;
}

class AddNotesState extends NoteState {
  AddNotesState(this.notes);
  List<Notes> notes;
}

class DeleteNotesState extends NoteState {
  DeleteNotesState(this.notes);
  List<Notes> notes;
}

class UpdateNotesState extends NoteState {
  UpdateNotesState(this.notes);
  List<Notes> notes;
}

class AllDeleteNotesState extends NoteState {}

class ShowNotesViewState extends NoteState {
  ShowNotesViewState(this.grid);
  bool grid = true;
}

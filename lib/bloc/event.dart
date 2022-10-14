import 'package:notes_flutter/model/notes.dart';

class NoteEvent {
  NoteEvent({this.notes});
  List<Notes>? notes;
}

class AddNoteEvent extends NoteEvent {
  AddNoteEvent(this.note);
  Notes note;
}

class UpdateNotesEvent extends NoteEvent {
  UpdateNotesEvent(this.note);
  final Notes note;
}

class DeleteNotesEvent extends NoteEvent {
  DeleteNotesEvent(this.id);
  int id;
}

class DeleteAllNotesEvent extends NoteEvent {}

class ShowAllNotesEvent extends NoteEvent {}

class ShowInGridNoteEvent extends NoteEvent {}

class ShowInListNotesEvent extends NoteEvent {}

class CloseDBEvent extends NoteEvent {}

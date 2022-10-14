import 'package:notes_flutter/model/notes.dart';

class SearchEvent {}

class SearchAllNotesEvent extends SearchEvent {}

class SearchGetNotesEventWithText extends SearchEvent {
  SearchGetNotesEventWithText(this.text, this.noteList);

  String text;
  List<Notes> noteList;
}

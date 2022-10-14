import 'package:notes_flutter/model/notes.dart';

class SearchState {}

class InitialsearchState extends SearchState {}

class LoadingsearchState extends SearchState {}

class LoadedsearchState extends SearchState {
  LoadedsearchState(this.notesList);
  List<Notes> notesList;
}

class SearchGetNotesStateWithText extends SearchState {
  SearchGetNotesStateWithText(this.searchList);
  List<Notes> searchList;
}

class SearchErrorState extends SearchState {
  SearchErrorState(this.message);
  String message;
}

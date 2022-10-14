import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/bloc_search/search_event.dart';
import 'package:notes_flutter/bloc_search/search_state.dart';
import 'package:notes_flutter/model/notes.dart';
import 'package:notes_flutter/repository/note_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final NoteRepository _repository = NoteRepository();
  SearchBloc() : super(InitialsearchState()) {
    on<SearchAllNotesEvent>((event, emit) async {
      emit(LoadingsearchState());
      try {
        List<Notes> notesList = await _repository.getAllNote();
        emit(LoadedsearchState(notesList));
      } catch (e) {
        emit(SearchErrorState(e.toString()));
      }
    });

    on<SearchGetNotesEventWithText>((event, emit) {
      List<Notes> noteList = event.noteList;
      List<Notes> searchList = [];

      searchList = noteList
          .where((element) => element.title!.contains(event.text.toLowerCase()))
          .toList();
      if (event.text.isEmpty) {
        emit(SearchGetNotesStateWithText(noteList));
      } else {
        emit(SearchGetNotesStateWithText(searchList));
      }
    });
  }
}

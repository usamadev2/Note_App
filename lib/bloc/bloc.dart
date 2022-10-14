import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/bloc/event.dart';
import 'package:notes_flutter/bloc/state.dart';
import 'package:notes_flutter/model/notes.dart';
import 'package:notes_flutter/repository/note_repository.dart';

class NotesBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository repository = NoteRepository();
  NotesBloc() : super(InitialNoteState()) {
    on<ShowAllNotesEvent>((event, emit) async {
      emit(LoadingNotesState());
      try {
        List<Notes> notes = await repository.getAllNote();
        emit(LoadedNoteState(notes));
      } catch (error) {
        emit(ErrorNotesState(error.toString()));
      }
    });

    on<AddNoteEvent>((event, emit) async {
      await repository.addNote(event.note);
      List<Notes> notes = await repository.getAllNote();
      emit(AddNotesState(notes));
    });

    on<DeleteAllNotesEvent>((event, emit) async {
      repository.deleteAllNote();
      emit(AllDeleteNotesState());
    });

    on<DeleteNotesEvent>((event, emit) async {
      await repository.deleteNote(event.id);
      List<Notes> notes = await repository.getAllNote();
      emit(DeleteNotesState(notes));
    });

    on<UpdateNotesEvent>((event, emit) async {
      await repository.upDateNote(event.note);
      List<Notes> notes = await repository.getAllNote();
      emit(UpdateNotesState(notes));
    });

    on<ShowInGridNoteEvent>((event, emit) {
      emit(ShowNotesViewState(true));
    });

    on<ShowInListNotesEvent>((event, emit) {
      emit(ShowNotesViewState(false));
    });

    on<CloseDBEvent>((event, emit) async {
      await repository.closeDBNote();
    });
  }
}

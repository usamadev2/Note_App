import 'package:notes_flutter/Database/db_helper.dart';
import 'package:notes_flutter/model/notes.dart';

class NoteRepository {
  final DBHelper _dbHelper = DBHelper();
  Future<List<Notes>> getAllNote() async => await _dbHelper.readAllNotes();
  Future<Notes> getNote(int id) async => await _dbHelper.readNote(id);
  Future<bool> deleteNote(int id) async => await _dbHelper.deleteNote(id);
  Future<bool> deleteAllNote() => _dbHelper.deleteAllNotes();
  Future<Notes> addNote(Notes notes) => _dbHelper.insertNote(notes);
  Future<bool> upDateNote(Notes notes) => _dbHelper.updateNotes(notes);
  Future<void> closeDBNote() => _dbHelper.closeDataBase();
}

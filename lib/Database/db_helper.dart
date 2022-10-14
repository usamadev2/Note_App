import 'dart:async';

import 'package:notes_flutter/model/notes.dart';
import 'package:notes_flutter/utils/constant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._init();

  static DBHelper? dbHelper;

  Database? database;

  factory DBHelper() {
    return dbHelper ??= DBHelper._init();
  }

  Future<Database> _getdb() async {
    return database ??= await initDatabase();
  }

  Future<Database> initDatabase() async {
    String dbPath = await getDatabasesPath();
    String dbFilePath = join(dbPath, NoteConstDB.databaseName);

    return await openDatabase(
      dbFilePath,
      version: NoteConstDB.databaseVersion,
      onCreate: onCreate,
    );
  }

  ///2
  Future<void> onCreate(Database db, int version) async {
    return db.execute(NoteConstDB.createTableCommand);
  }

  Future<void> closeDataBase() async {
    Database db = await _getdb();
    return db.close();
  }

  Future<Notes> insertNote(Notes notes) async {
    Database db = await _getdb();
    int insert = await db.insert(NoteConstDB.tableName, notes.toMap());
    return insert > 0
        ? notes.copyWith(id: insert)
        : throw Exception('Insertion Field');
  }

  Future<Notes> readNote(int id) async {
    Database db = await _getdb();

    List<Map<String, Object?>> listMap = await db.query(NoteConstDB.tableName,
        columns: NoteConstDB.columnNames,
        where: '${NoteConstDB.colId} = ?',
        whereArgs: [id]);

    if (listMap.isNotEmpty) {
      return Notes.fromMap(listMap.first);
    } else {
      throw 'ID $id not found';
    }
  }

  Future<List<Notes>> readAllNotes() async {
    Database db = await _getdb();

    List<Map<String, Object?>> listQuery = await db.query(
      NoteConstDB.tableName,
      orderBy: NoteConstDB.orderByTime,
    );

    return listQuery.map((element) => Notes.fromMap(element)).toList();
  }

  Future<bool> updateNotes(Notes notes) async {
    Database db = await _getdb();

    int update = await db.update(
      NoteConstDB.tableName,
      notes.toMap(),
      where: '${NoteConstDB.colId} = ?',
      whereArgs: [notes.id],
    );
    return update > 0;
  }

  Future<bool> deleteNote(int id) async {
    Database db = await _getdb();

    int deleteNote = await db.delete(NoteConstDB.tableName,
        where: '${NoteConstDB.colId} = ?', whereArgs: [id]);
    return deleteNote > 0;
  }

  Future<bool> deleteAllNotes() async {
    final Database db = await _getdb();

    int changesMade = await db.rawDelete(NoteConstDB.deleteEverything);
    return changesMade > 0;
  }
}

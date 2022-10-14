class NoteConstDB {
  static const String databaseName = 'note.db';
  static const int databaseVersion = 1;

  static const String tableName = 'NOTES';
  static const String colId = 'id';
  static const String colTitle = 'title';
  static const String colDescription = 'description';
  static const String colTime = 'time';

  static const String _idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String _titleType = 'TEXT NOT NULL';

  static const String orderByTime = '$colTime ASC';

  static const String deleteEverything = 'DELETE FROM $tableName';

  ///..............1

  static const List<String> columnNames = [
    colId,
    colTitle,
    colDescription,
    colTime,
  ];

  static const String createTableCommand = '''
  CREATE TABLE $tableName(
   $colId  $_idType,
   $colTitle $_titleType,
   $colDescription $_titleType,
   $colTime $_titleType
  )
''';
}

class UserTable {
  static const String tableName = "users";

  static const String createTable = '''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      age INTEGER
    )
  ''';
}
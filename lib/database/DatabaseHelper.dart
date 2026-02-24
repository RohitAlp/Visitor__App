import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user_table.dart';

class DatabaseHelper {

  static Future<Database> initDatabase() async {

    String path = join(await getDatabasesPath(), 'visitor.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(UserTable.createTable);
      },
    );
  }

}
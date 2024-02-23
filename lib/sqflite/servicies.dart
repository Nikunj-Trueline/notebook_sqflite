import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
 static  Future<Database> dbHelper() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {

      await db.execute(
          'CREATE TABLE Notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)');
    });

    return database;
  }
}

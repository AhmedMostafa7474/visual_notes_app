import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'visual_item1.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Items(id TEXT PRIMARY KEY NOT NULL, title TEXT NOT NULL,picture TEXT NOT NULL, date TEXT NOT NULL, description TEXT NOT NULL, status TEXT)",
        );
      },
      version: 1,
    );
  }
}
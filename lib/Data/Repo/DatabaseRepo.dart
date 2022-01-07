import 'package:sqflite/sqflite.dart';
import 'package:visual_notes_app/Data/LocalStorage/VisualItemStorage.dart';
import 'package:visual_notes_app/Data/Models/Visual_item.dart';

class DatabaseRepo
{
  final DatabaseHandler _databaseHandler;

  DatabaseRepo(this._databaseHandler);
  Future<List<VisualItem>> retrieveItems() async {
    final Database db = await _databaseHandler.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('Items');
    return queryResult.map((e) => VisualItem.fromJson(e)).toList();
  }

  Future<void> insertItem(VisualItem visualItem) async {
    int result = 0;
    final Database db = await _databaseHandler.initializeDB() ;
     await db.insert('Items', visualItem.toJson());
  }

  Future<void> deleteItem(String id) async {
    final db = await _databaseHandler.initializeDB();
    await db.delete(
      'Items',
      where: "id = ?",
      whereArgs: [id],
    );
  }
  Future<void> updateDayItem(String text,String id) async {
    final db = await _databaseHandler.initializeDB();
    await db.rawUpdate('UPDATE Days SET note = ? WHERE id = ?', [text, id]);
  }
  Future<void> updateItem (Map<String, dynamic> row ,id) async {
    final db = await _databaseHandler.initializeDB() ;
    await db.update(
        'Items',
        row,
        where: 'id = ?',
        whereArgs: [id]);
  }
}
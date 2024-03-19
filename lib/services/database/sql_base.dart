import 'dart:developer';
import 'package:NewsFeed/services/database/sql_queries.dart';
import 'package:NewsFeed/widgets/app_dialog_box.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBBase {
  static const String _dbName = 'newsapp.db';
  static Database? _instance;

  static Future<Database> get db async {
    if (_instance != null) {
      return _instance!;
    }
    await _initDatabase();
    return _instance!;
  }

  static Future<void> _initDatabase() async {
    try {
      log("initDatabase: called");
      String databasesPath = getApplicationDocumentsDirectory().toString();
      String path = join(databasesPath, _dbName);
      log("initDatabase: $path");

      _instance = await openDatabase(path, version: 2, onCreate: _onCreate);

      log("initDatabase: ${_instance?.isOpen}");
    } catch (e) {
      log("_initDatabase(): Error - $e");
      rethrow;
    }
  }

  static Future<void> cleanDatabase() async {
    try {
      Database dbClient = await db;
      await dbClient.execute(DBQueries.truncateData);
    } on Exception catch (e) {
      print(e.toString() );
      rethrow;
    }
  }

  static Future<void> _onCreate(Database db, int newVersion) async {
    try {
      log("_onCreate: called");
      await db.execute(DBQueries.createTable);
    } catch (e) {
      log("_onCreate: Error - $e");
      rethrow;
    }
  }

  static Future<void> closeDatabase() async {
    try {
      if (_instance != null) {
        await _instance!.close();
        _instance = null; // Clear instance after closing
      }
    } catch (e) {
      log("closeDatabase(): Error - $e");
    }
  }

  // CRUD Operations

  static Future<int> insert(Map<String, dynamic> data) async {
    try {
      Database dbClient = await db;
      // int res = await dbClient.insert(DBQueries.table1, row);
      int res = await dbClient.rawInsert(DBQueries.insertData, [
        "${data['title']}",
        "${data['description']}",
        "${data['content']}",
        "${data['source']}",
        "${data['src']}",
        "${data['url']}",
        "${data['urlToImage']}",
        "${data['author']}",
        "${data['publishedAt']}"
      ]);
      log("insert: Inserted $res rows");
      await queryAllLikedNews();

      return res;
    } catch (e) {
      log("insert(): Error - $e");
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> queryAllLikedNews() async {
    try {
      Database dbClient = await db;
      List<Map<String, dynamic>> _list = await dbClient.query(DBQueries.table1);
      return _list;
    } catch (e) {
      log("queryAllNotes(): Error - $e");
      rethrow;
    }
  }

  static Future<int> delete({String? title}) async {
    try {
      Database dbClient = await db;
      int res = await dbClient.delete(
        DBQueries.table1,
        where: '${DBQueries.col2} = ?',
        whereArgs: [title],
      );
      log("delete: Deleted $res rows");
      return res;
    } catch (e) {
      log("delete(): Error - $e");
      rethrow;
    }
  }

  static Future<bool> checkIsLiked(String title) async {
    bool res = false;
    try {
      Database dbClient = await db;
      var list = await dbClient.query(
        DBQueries.table1,
        where: '${DBQueries.col2} = ?',
        whereArgs: [title],
      );
      if (list.isNotEmpty) {
        res = true;
      }
    } on Exception catch (e) {
      log(name: "checkIsLiked", "${e.toString()}");
    }
    return res;
  }
}

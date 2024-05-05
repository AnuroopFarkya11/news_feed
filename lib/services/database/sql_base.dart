import 'dart:developer';
import 'package:com.newsfeed.app/services/database/article_sql_queries.dart';
import 'package:com.newsfeed.app/services/database/user_sql_queries.dart';
import 'package:com.newsfeed.app/widgets/app_dialog_box.dart';
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

      _instance = await openDatabase(path, version: 3, onCreate: _onCreate);
      // await insertUser(
      //     {'userId': 'anuroopf02@gmail.com', 'name': 'Anuroop Farkya',});
      log("initDatabase: ${_instance?.isOpen}");
    } catch (e) {
      log("_initDatabase(): Error - $e");
      rethrow;
    }
  }

  static Future<void> cleanDatabase() async {
    try {
      Database dbClient = await db;
      await dbClient.execute(ArticleDBQueries.truncateData);
      await dbClient.execute(ArticleDBQueries.truncateCustomNewsData);
    } on Exception catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<void> _onCreate(Database db, int newVersion) async {
    try {
      log("_onCreate: called");
      await db.execute(ArticleDBQueries.createTable);
      await db.execute(ArticleDBQueries.createTable2);
      await db.execute(UserDBQueries.createTable);
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

  static Future<int> insertArticle(Map<String, dynamic> data) async {
    try {
      Database dbClient = await db;
      // int res = await dbClient.insert(DBQueries.table1, row);
      int res = await dbClient.rawInsert(ArticleDBQueries.insertData, [
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
  static Future<int> insertCustomArticle(Map<String, dynamic> data) async {
    try {
      Database dbClient = await db;
      // int res = await dbClient.insert(DBQueries.table1, row);
      int res = await dbClient.rawInsert(ArticleDBQueries.insertCustomizedNews, [
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
      List<Map<String, dynamic>> _list =
          await dbClient.query(ArticleDBQueries.table1);
      return _list;
    } catch (e) {
      log("queryAllNotes(): Error - $e");
      rethrow;
    }
  }
  static Future<List<Map<String, dynamic>>> queryAllCustomNews() async {
    try {
      Database dbClient = await db;
      List<Map<String, dynamic>> _list =
          await dbClient.query(ArticleDBQueries.table2);
      return _list;
    } catch (e) {
      log("queryAllNotes(): Error - $e");
      rethrow;
    }
  }

  static Future<int> deleteArticle({String? title}) async {
    try {
      Database dbClient = await db;
      int res = await dbClient.delete(
        ArticleDBQueries.table1,
        where: '${ArticleDBQueries.col2} = ?',
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
        ArticleDBQueries.table1,
        where: '${ArticleDBQueries.col2} = ?',
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

  static Future<void> insertUser(Map<String, dynamic> values) async {
    try {
      Database dbClient = await db;
      int res = await dbClient.insert(UserDBQueries.table, values);
      log("insertUser(): result $res");
      await queryAllUsers();
    } on Exception catch (e) {
      log("insertUser(): Error - $e");
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> queryAllUsers() async {
    try {
      Database dbClient = await db;
      List<Map<String, dynamic>> _list =
          await dbClient.query(UserDBQueries.table);
      log("User list ${_list.toString()}");
      return _list;
    } catch (e) {
      log("queryAllUsers(): Error - $e");
      rethrow;
    }
  }

  static Future<int> updateCountry({String? countryCode}) async {
    try {
      Database dbClient = await db;
      int res = await dbClient
          .update(UserDBQueries.table, {UserDBQueries.col6: countryCode});

      print("updateCountry res : $res");
      return res;
    } on Exception catch (e) {
      log("updateCountry error : $e");
    }
    return 0;
  }

  static Future<String?> getUserCountry({String? userId}) async {
    String? country;
    try {
      Database dbClient = await db;
      List<Map<String, dynamic>> res = await dbClient.query(UserDBQueries.table,
          where: '${UserDBQueries.col1} = ?', whereArgs: [userId]);
      if (res.isNotEmpty) {
        country = res.last[UserDBQueries.col6];
      }
    } on Exception catch (e, s) {
      log('getUserCountry error $e : $s');
    }
    return country;
  }
}

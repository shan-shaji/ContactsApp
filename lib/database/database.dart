import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  //Creating a database with name test.dn in your directory
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "mydb.db");
    var theDb = await openDatabase(path, version: 5, onCreate: _onCreate);
    return theDb;
  }

  // Creating a table name Contact with fields
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table

    await db.execute(
        "CREATE TABLE IF NOT EXISTS user (userId TEXT,name TEXT,yop TEXT,username TEXT,password TEXT)");

    print("Created tables");
  }

  void clearTable() async {
    var dbClient = await db;
    await dbClient.rawQuery("DROP TABLE if exists users");
    _onCreate(dbClient, 1);
    print("Created tables");
  }



  Future<int> getUsersCount() async {
    var dbClient = await db;
    List<Map> list =
    await dbClient.rawQuery("SELECT count(*) as sum from users");
    return list[0]["sum"];
  }
}

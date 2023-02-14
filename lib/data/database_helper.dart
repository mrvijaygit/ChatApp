import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/get_message_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Message(id INTEGER, message TEXT)");
  }

  Future<int> saveMessage(Message msg) async {
    var dbClient = await db;
    int res = await dbClient!.insert("Message", msg.toMap());
    return res;
  }

  Future<List<Message>> getAllMessage() async {
    var dbClient = await db;
    List<Message> getMsg=[];
    List<Map<String,dynamic>> res = await dbClient!.query("Message");
    for(var row in res)
    {
      getMsg.add(Message.map(row));
    }
    return Future<List<Message>>.value(getMsg);
  }


}

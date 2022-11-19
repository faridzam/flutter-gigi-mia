import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/LansiaModel.dart';

class DBHelperLansia {
  static Database? _db;

  static const String DB_Name = 'pengasuh_gigi.db';
  static const String Table_Lansia = 'lansia';
  static const int version = 1;

  static const String C_LansiaID = 'id';
  static const String C_UserId = 'user_id';
  static const String C_NamaLansia = 'nama';
  static const String C_UsiaLansia = 'usia';
  static const String C_JenisKelamin = 'jeniskelamin';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();

    return _db;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_Lansia ("
        "$C_LansiaID INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$C_NamaLansia TEXT UNIQUE, "
        "$C_UsiaLansia TEXT, "
        "$C_JenisKelamin TEXT "
        ")");
  }

  Future<int> saveDataLansia(LansiaModel lansia) async {
    var dbClient = await db;
    var res = await dbClient!.insert(Table_Lansia, lansia.toMap());
    return res;
  }

  Future<List<LansiaModel>> showLansia() async {
    final prefs = await SharedPreferences.getInstance();
    final int? _id = prefs.getInt('id');
    final Database db = await initDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      'lansia',
      where: "user_id = ?",
      whereArgs: [_id],
    );
    return queryResult.map((e) => LansiaModel.fromMap(e)).toList();
  }
}

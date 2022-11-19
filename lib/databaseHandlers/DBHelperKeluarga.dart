import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/KeluargaModel.dart';

class DBHelperKeluarga {
  static Database? _db;

  static const String DB_Name = 'pengasuh_gigi.db';
  static const String Table_Keluarga = 'keluarga';
  static const int version = 1;

  static const String C_KeluargaID = 'id';
  static const String C_Userid = 'user_id';
  static const String C_NamaKeluarga = 'nama';
  static const String C_UsiaKeluarga = 'usia';
  static const String C_TanggalLahir = 'tanggallahir';
  static const String C_TingkatPendidikan = 'tingkatpendidikan';

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
    await db.execute("CREATE TABLE $Table_Keluarga ("
        "$C_KeluargaID INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$C_Userid INTEGER , "
        "$C_NamaKeluarga TEXT, "
        "$C_UsiaKeluarga TEXT, "
        "$C_TanggalLahir TEXT,"
        "$C_TingkatPendidikan TEXT "
        ")");
  }

  Future<int> saveDataKeluarga(KeluargaModel keluarga) async {
    var dbClient = await db;
    var res = await dbClient!.insert(Table_Keluarga, keluarga.toMap());
    return res;
  }

  Future<List<KeluargaModel>> showKeluarga() async {
    final prefs = await SharedPreferences.getInstance();
    final int? _id = prefs.getInt('id');
    final Database db = await initDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      'keluarga',
      where: "user_id = ?",
      whereArgs: [_id],
    );
    return queryResult.map((e) => KeluargaModel.fromMap(e)).toList();
  }
}

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/PemeriksaanModel.dart';


class DBHelperPemeriksaan {
  static Database? _db;

  static const String DB_Name = 'pengasuh_gigi.db';
  static const String Table_Lansia = 'pemeriksaan';
  static const int version = 1;

  static const String C_LansiaID = 'id';
  static const String C_UserId = 'user_id';
  static const String C_NamaLansia = 'nama';
  static const String C_UsiaLansia = 'umur';
  static const String C_JenisKelamin = 'jenis_kelamin';
  static const String C_KelainanGigi = 'kelainan_gigi';

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
        "$C_JenisKelamin TEXT, "
        "$C_KelainanGigi TEXT "
        ")");
  }

  Future<int> saveDataPemeriksaan(PemeriksaanModel pemeriksaan) async {
    var dbClient = await db;
    var res = await dbClient!.insert(Table_Lansia, pemeriksaan.toMap());
    return res;
  }

}

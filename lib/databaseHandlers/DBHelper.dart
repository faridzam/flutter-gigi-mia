import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io' as io;

import '../models/UserModel.dart';


class DBHelper{
  static Database? _db;

  static const String DB_Name = 'pengasuh_gigi.db';
  static const String Table_User = 'user';
  static const int version = 1;

  static const String C_UserID = 'id';
  static const String C_UserName = 'username';
  static const String C_Password = 'password';
  static const String C_Phone = 'phone';

  Future<Database?> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDB();

    return _db;
  }

  initDB() async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async{
    await db.execute("CREATE TABLE $Table_User ("
        "$C_UserID INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$C_UserName TEXT UNIQUE, "
        "$C_Phone TEXT, "
        "$C_Password TEXT "
        ")");

    // await _createDefaultTugas(db);
  }

  Future<int> saveData(UserModel user) async{
    var dbClient = await db;
    var res = await dbClient!.insert(Table_User, user.toMap());
    return res;
  }

  Future<UserModel?> getLoginUser(String username, String password) async{
    var dbClient = await db;
    var res = await dbClient!.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_UserName = '$username' AND "
        "$C_Password = '$password'");

    if(res.length > 0){
      return UserModel.fromMap(res.first);
    }
    return null;
  }

  Future<void> _createDefaultTugas(Database database) async {
    Batch batch = database.batch();
    batch.insert("tugas", {'id': 1, 'category': 1, 'name' : 'tugas 1', 'description': 'Penyuluhan Kesehatan Gigi (Materi : Anatomi Gigi)'});
    batch.insert("tugas", {'id': 2, 'category': 1, 'name' : 'tugas 2', 'description': 'Pemeriksaan Gigi Sederhana'});
    batch.insert("tugas", {'id': 3, 'category': 1, 'name' : 'tugas 3', 'description': 'Rujukan (Bila ada)'});
    batch.insert("tugas", {'id': 4, 'category': 1, 'name' : 'tugas 4', 'description': 'Pembuatan Laporan Periode I'});
    batch.insert("tugas", {'id': 5, 'category': 2, 'name' : 'tugas 1', 'description': 'Penyuluhan Kesehatan Gigi (Materi : Penyakit Gigi dan Mulut)'});
    batch.insert("tugas", {'id': 6, 'category': 2, 'name' : 'tugas 2', 'description': 'Pemeriksaan Gigi Sederhana'});
    batch.insert("tugas", {'id': 7, 'category': 2, 'name' : 'tugas 3', 'description': 'Rujukan (Bila ada)'});
    batch.insert("tugas", {'id': 8, 'category': 2, 'name' : 'tugas 4', 'description': 'Pembuatan Laporan Periode II'});
    batch.insert("tugas", {'id': 9, 'category': 3, 'name' : 'tugas 1', 'description': 'Penyuluhan Kesehatan Gigi (Materi : Pencegahan Kerusakan Gigi)'});
    batch.insert("tugas", {'id': 10, 'category': 3, 'name' : 'tugas 2', 'description': 'Pemeriksaan Gigi Sederhana'});
    batch.insert("tugas", {'id': 11, 'category': 3, 'name' : 'tugas 3', 'description': 'Rujukan (Bila ada)'});
    batch.insert("tugas", {'id': 12, 'category': 3, 'name' : 'tugas 4', 'description': 'Pembuatan Laporan Periode III'});
    batch.insert("tugas", {'id': 13, 'category': 4, 'name' : 'tugas 1', 'description': 'Penyuluhan Kesehatan Gigi (Materi : Memelihara Kesehatan Gigi Lansia)'});
    batch.insert("tugas", {'id': 14, 'category': 4, 'name' : 'tugas 2', 'description': 'Pemeriksaan Gigi Sederhana'});
    batch.insert("tugas", {'id': 15, 'category': 4, 'name' : 'tugas 3', 'description': 'Rujukan (Bila ada)'});
    batch.insert("tugas", {'id': 16, 'category': 4, 'name' : 'tugas 4', 'description': 'Pembuatan Laporan Periode IV'});

    await batch.commit(noResult: true);
  }

}
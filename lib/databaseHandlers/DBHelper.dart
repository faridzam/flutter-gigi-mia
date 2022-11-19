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
  static const String Table_Lansia = 'lansia';
  static const String Table_Keluarga = 'keluarga';
  static const int version = 1;

  static const String C_UserID = 'id';
  static const String C_UserName = 'username';
  static const String C_Password = 'password';
  static const String C_Phone = 'phone';

  static const String C_LansiaID = 'id';
  static const String C_UserId = 'user_id';
  static const String C_NamaLansia = 'nama';
  static const String C_UsiaLansia = 'usia';
  static const String C_JenisKelamin = 'jeniskelamin';

  static const String C_KeluargaID = 'id';
  static const String C_User_ID = 'user_id';
  static const String C_NamaKeluarga = 'nama';
  static const String C_UsiaKeluarga = 'usia';
  static const String C_TanggalLahir = 'tanggallahir';
  static const String C_TingkatPendidikan = 'tingkatpendidikan';

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
    await db.execute("CREATE TABLE question ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "question_text TEXT UNIQUE "
        ")");
    await db.execute("CREATE TABLE answer ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "question_id INTEGER, "
        "answer_text TEXT, "
        "isTrue INTEGER "
        ")");
    await db.execute("CREATE TABLE pretest ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "user_id INTEGER, "
        "score INTEGER "
        ")");
    await db.execute("CREATE TABLE posttest ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "user_id INTEGER, "
        "score INTEGER "
        ")");

    await db.execute("CREATE TABLE $Table_Lansia ("
        "$C_LansiaID INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$C_UserId INTEGER, "
        "$C_NamaLansia TEXT, "
        "$C_UsiaLansia TEXT, "
        "$C_JenisKelamin TEXT "
        ")");
    await db.execute("CREATE TABLE $Table_Keluarga ("
        "$C_KeluargaID INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$C_User_ID INTEGER , "
        "$C_NamaKeluarga TEXT, "
        "$C_UsiaKeluarga TEXT, "
        "$C_TanggalLahir TEXT, "
        "$C_TingkatPendidikan TEXT "
        ")");

    await _createDefaultQuestion(db);
    await _createDefaultAnswer(db);
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

  Future<void> _createDefaultQuestion(Database database) async {
    Batch batch = database.batch();
    batch.insert("question", {'id': 1, 'question_text': "pertanyaan1?"});
    batch.insert("question", {'id': 2, 'question_text': "pertanyaan2?"});
    await batch.commit(noResult: true);
  }
  Future<void> _createDefaultAnswer(Database database) async {
    Batch batch = database.batch();
    batch.insert("answer", {'id': 1, 'question_id': 1, 'answer_text': "salah", 'isTrue': 0});
    batch.insert("answer", {'id': 2, 'question_id': 1, 'answer_text': "benar", 'isTrue': 1});
    batch.insert("answer", {'id': 3, 'question_id': 1, 'answer_text': "salah", 'isTrue': 0});
    batch.insert("answer", {'id': 4, 'question_id': 1, 'answer_text': "salah", 'isTrue': 0});
    batch.insert("answer", {'id': 5, 'question_id': 2, 'answer_text': "salah", 'isTrue': 0});
    batch.insert("answer", {'id': 6, 'question_id': 2, 'answer_text': "salah", 'isTrue': 0});
    batch.insert("answer", {'id': 7, 'question_id': 2, 'answer_text': "benar", 'isTrue': 1});
    batch.insert("answer", {'id': 8, 'question_id': 2, 'answer_text': "salah", 'isTrue': 0});
    await batch.commit(noResult: true);
  }

}
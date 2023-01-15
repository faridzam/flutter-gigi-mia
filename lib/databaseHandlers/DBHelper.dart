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
  static const String C_Email = 'email';
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
        "$C_Email TEXT UNIQUE, "
        "$C_Phone TEXT, "
        "$C_Password TEXT "
        ")");
    await db.execute("CREATE TABLE question_keluarga ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "question_text TEXT UNIQUE "
        ")");
    await db.execute("CREATE TABLE answer_keluarga ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "question_id INTEGER, "
        "answer_text TEXT, "
        "isTrue INTEGER "
        ")");
    await db.execute("CREATE TABLE question_lansia ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "question_text TEXT UNIQUE "
        ")");
    await db.execute("CREATE TABLE answer_lansia ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "question_id INTEGER, "
        "answer_text TEXT, "
        "isTrue INTEGER "
        ")");
    await db.execute("CREATE TABLE tindakan ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "type INTEGER, "
        "text TEXT "
        ")");
    await db.execute("CREATE TABLE tindakan_user ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "user_id INTEGER, "
        "tindakan_id INTEGER, "
        "type INTEGER, "
        "answer INTEGER "
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

    await _createDefaultQuestionKeluarga(db);
    await _createDefaultQuestionLansia(db);
    await _createDefaultAnswerKeluarga(db);
    await _createDefaultAnswerLansia(db);
    await _createDefaultTindakanChecklist(db);
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

  Future<int> changePassword(id, oldPassword, password) async{
    var dbClient = await db;
    var user = await dbClient!.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_UserID = '$id' AND "
        "$C_Password = '$oldPassword'");

    if(user.length > 0){
      var selectedUser = UserModel.fromMap(user.first);

      int updateCount = await dbClient.rawUpdate('''
      UPDATE $Table_User
      SET $C_Password = ? 
      WHERE $C_UserID = ?
      ''',
          [password, id]);
      return updateCount;
    }
    return 0;
  }

  Future<void> _createDefaultQuestionKeluarga(Database database) async {
    Batch batch = database.batch();
    batch.insert("question_keluarga", {
      'id': 1,
      'question_text': "1.	Dibawah ini macam-macam gigi, kecuali??"
    });
    batch.insert("question_keluarga", {
      'id': 2,
      'question_text':
      "2.	Macam-macam gigi, bentuk dan fungsinya, gigi seri berfungsi untuk?"
    });
    batch.insert("question_keluarga", {
      'id': 3,
      'question_text': "3.	Urutan lapisan gigi dari yang terluar?"
    });
    batch.insert("question_keluarga", {
      'id': 4,
      'question_text': "4.	Kapan waktu yang tepat untuk menyikat gigi? "
    });
    batch.insert("question_keluarga", {
      'id': 5,
      'question_text':
      "5.	Menghilangkan sisa-sisa makanan yang melekat pada permukaan gigi dilakukan dengan cara?"
    });
    batch.insert("question_keluarga", {
      'id': 6,
      'question_text':
      "6.	Jenis makanan apa yang dapat menyehatkan atau membantu melepaskan sisa-sisa makanan pada gigi? "
    });
    batch.insert("question_keluarga", {
      'id': 7,
      'question_text':
      "7.	Berapa bulan sekali untuk pencegahan kita periksa ke klinik gigi/puskesmas/dokter gigi? "
    });
    batch.insert("question_keluarga", {
      'id': 8,
      'question_text':
      "8.	Endapan keras yang melengket erat pada permukaan gigi yang berwarna kekuningan,kecoklatan, dan kehitaman disebut? "
    });
    batch.insert("question_keluarga", {
      'id': 9,
      'question_text': "9.	Karang gigi dapat dibersihkan dengan cara?"
    });
    batch.insert("question_keluarga", {
      'id': 10,
      'question_text':
      "10. Mengunyah makanan hanya dengan menggunakan salah satu sisi rahang dapat menyebabkan?"
    });
    batch.insert("question_keluarga", {
      'id': 11,
      'question_text':
      "1. Periksa gigi ke puskesmas/ klinik gigi minimal 6 bulan sekali"
    });
    batch.insert("question_keluarga", {
      'id': 12,
      'question_text': "2. Di dalam gigi berlubang terdapat ulat"
    });
    batch.insert("question_keluarga", {
      'id': 13,
      'question_text': "3. Membersihkan gigi bisa hanya dengan berkumur-kumur "
    });
    batch.insert("question_keluarga", {
      'id': 14,
      'question_text':
      "4. Kandungan fluoride dalam pasta gigi penting untuk mencegah gigi berlubang"
    });
    batch.insert("question_keluarga", {
      'id': 15,
      'question_text':
      "5. Menyikat gigi paling tepat dilakukan setelah sarapan pagi dan sebelum tidur malam"
    });
    batch.insert("question_keluarga", {
      'id': 16,
      'question_text':
      "6. Buah – buahan yang berair dan berserat tidak berpengaruh terhadap kesehatan gigi"
    });
    batch.insert("question_keluarga", {
      'id': 17,
      'question_text':
      "7. Gerakan sikat gigi yang baik adalah gerakan cepat dan keras "
    });
    batch.insert("question_keluarga", {
      'id': 18,
      'question_text':
      "8. Menyikat gigi dengan gerakan maju mundur dilakukan pada bagian pengunyahan"
    });
    batch.insert("question_keluarga", {
      'id': 19,
      'question_text':
      "9. Untuk gigi bagian depan gerakan sikat gigi sebaiknya turun naik"
    });
    batch.insert("question_keluarga", {
      'id': 20,
      'question_text':
      "10. Sikat gigi yang baik adalah tangkai lurus dan bulu sikatnya rata"
    });

    await batch.commit(noResult: true);
  }

  Future<void> _createDefaultQuestionLansia(Database database) async {
    Batch batch = database.batch();
    batch.insert("question_lansia", {
      'id': 1,
      'question_text':
      "1.	Apakah upaya yang dapat dilakukan untuk membersihkan gigi mulut dari sisa makanan dengan sikat gigi ?"
    });
    batch.insert("question_lansia", {
      'id': 2,
      'question_text':
      "2.	Alat dan bahan apa yang harus dibersihkan pada saat menggosok gigi?"
    });
    batch.insert("question_lansia", {
      'id': 3,
      'question_text':
      "3.	Makanan seperti apa yang baik untuk kesehatan gigi dan mulut?"
    });
    batch.insert("question_lansia", {
      'id': 4,
      'question_text': "4.	Berapa kali kita menggosok gigi dalam satu hari ?"
    });
    batch.insert("question_lansia", {
      'id': 5,
      'question_text': "5.	Kapan waktu yang tepat untuk menggosok gigi ?"
    });
    batch.insert("question_lansia", {
      'id': 6,
      'question_text':
      "8.	Gerakan apakah yang digunakan untuk menggosok gigi bagian kunyah ?"
    });
    batch.insert("question_lansia", {
      'id': 7,
      'question_text': "7.	Apa kebiasan yang buruk dalam menggosok gigi ?"
    });
    batch.insert("question_lansia", {
      'id': 8,
      'question_text':
      "8.	Gerakan apakah yang digunakan untuk menggosok gigi bagian kunyah?"
    });
    batch.insert("question_lansia", {
      'id': 9,
      'question_text': "9.	Bagaimana memilih pasta gigi yang baik?"
    });
    batch.insert("question_lansia",
        {'id': 10, 'question_text': "10.	Akibat tidak menggosok gigi adalah?"});
    batch.insert("question_lansia", {
      'id': 11,
      'question_text':
      "1. Saya menggosok gigi sehari 2 kali pagi sesudah sarapan dan malam sebelum tidur"
    });
    batch.insert("question_lansia", {
      'id': 12,
      'question_text':
      "2. Saya menggosok gigi dengan menggunakan sikat gigi dan pasta gigit"
    });
    batch.insert("question_lansia", {
      'id': 13,
      'question_text': "3. Saya menggunakan sikat gigi bersama-sama"
    });
    batch.insert("question_lansia", {
      'id': 14,
      'question_text':
      "4. Saya mengganti sikat gigi ketika rusak dan maksimal 3 bulan sekali"
    });
    batch.insert("question_lansia", {
      'id': 15,
      'question_text': "5. Saya menggunakan pasta gigi untuk menggosok gigi"
    });
    batch.insert("question_lansia", {
      'id': 16,
      'question_text':
      "6. Saya menggosok gigi bagian depan dengan gerakan memutar atau maju mundur pendek-pendek"
    });
    batch.insert("question_lansia", {
      'id': 17,
      'question_text': "7. Saya menggosok lidah saya dengan gerakan maju mudur "
    });
    batch.insert("question_lansia", {
      'id': 18,
      'question_text':
      "8. Normalnya gusi memang mudah berdarah saat menyikat gigi"
    });
    batch.insert("question_lansia", {
      'id': 19,
      'question_text':
      "9. Gigi akan ngilu saat berkumur/meminum air dingin atau es "
    });
    batch.insert("question_lansia", {
      'id': 20,
      'question_text':
      "10. Menyikat gigi bagian depan saja, karena gigi tersebut sering dilihat"
    });
    await batch.commit(noResult: true);
  }

  Future<void> _createDefaultAnswerKeluarga(Database database) async {
    Batch batch = database.batch();
    batch.insert("answer_keluarga", {
      'id': 1,
      'question_id': 1,
      'answer_text': "a.	Gigi seri ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 2,
      'question_id': 1,
      'answer_text': "b.	Gigi taring",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 3,
      'question_id': 1,
      'answer_text': "c.	Gigi susu",
      'isTrue': 1
    });
    batch.insert("answer_keluarga", {
      'id': 4,
      'question_id': 1,
      'answer_text': "d.	Gigi geraham ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 5,
      'question_id': 2,
      'answer_text': "a.	Memotong ",
      'isTrue': 1
    });
    batch.insert("answer_keluarga", {
      'id': 6,
      'question_id': 2,
      'answer_text': "b.	Mengunyah ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga",
        {'id': 7, 'question_id': 2, 'answer_text': "c.	Merobek ", 'isTrue': 0});
    batch.insert("answer_keluarga", {
      'id': 8,
      'question_id': 2,
      'answer_text': "d.	Menghaluskan ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 9,
      'question_id': 3,
      'answer_text': "a.	Dentin – Email – Pulpa - Sementum ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 10,
      'question_id': 3,
      'answer_text': "b.	Dentin – Pulpa – Email – Sementum",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 11,
      'question_id': 3,
      'answer_text': "c.	Email – Dentin – Pulpa – Sementum",
      'isTrue': 1
    });
    batch.insert("answer_keluarga", {
      'id': 12,
      'question_id': 3,
      'answer_text': "d.	Email – Dentin – Sementum - Pulpa",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 13,
      'question_id': 4,
      'answer_text': "a.	Sehabis mandi ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 14,
      'question_id': 4,
      'answer_text': "b.	Sehabis makan",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 15,
      'question_id': 4,
      'answer_text': "c.	Siang hari",
      'isTrue': 1
    });
    batch.insert("answer_keluarga", {
      'id': 16,
      'question_id': 4,
      'answer_text': "d.	Sehabis makan dan sebelum tidur malam ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 17,
      'question_id': 5,
      'answer_text': "a.	Menyikat gigi  ",
      'isTrue': 1
    });
    batch.insert("answer_keluarga", {
      'id': 18,
      'question_id': 5,
      'answer_text': "b.	Scalling ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 19,
      'question_id': 5,
      'answer_text': "c.	Penambalan gigi",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 20,
      'question_id': 5,
      'answer_text': "d.	Bleaching ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga",
        {'id': 21, 'question_id': 6, 'answer_text': "a.	Manis ", 'isTrue': 0});
    batch.insert("answer_keluarga",
        {'id': 22, 'question_id': 6, 'answer_text': "b.	Asam ", 'isTrue': 0});
    batch.insert("answer_keluarga", {
      'id': 23,
      'question_id': 6,
      'answer_text': "c.	Berserat berair ",
      'isTrue': 1
    });
    batch.insert("answer_keluarga", {
      'id': 24,
      'question_id': 6,
      'answer_text': "d.	Es cream ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 25,
      'question_id': 7,
      'answer_text': "a.	6 bulan sekali",
      'isTrue': 1
    });
    batch.insert("answer_keluarga", {
      'id': 26,
      'question_id': 7,
      'answer_text': "b.	7 bulan sekali",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 27,
      'question_id': 7,
      'answer_text': "c.	8 bulan sekali",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 28,
      'question_id': 7,
      'answer_text': "d.	9 bulan sekali",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 29,
      'question_id': 8,
      'answer_text': "a.	Karang gigi",
      'isTrue': 1
    });
    batch.insert("answer_keluarga", {
      'id': 30,
      'question_id': 8,
      'answer_text': "b.	Radang gusi ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 31,
      'question_id': 8,
      'answer_text': "c.	Karies gigi ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga",
        {'id': 32, 'question_id': 8, 'answer_text': "d.	Plak ", 'isTrue': 0});
    batch.insert("answer_keluarga", {
      'id': 33,
      'question_id': 9,
      'answer_text': "a.	Scalling",
      'isTrue': 1
    });
    batch.insert("answer_keluarga", {
      'id': 34,
      'question_id': 9,
      'answer_text': "b.	Penambalan ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 35,
      'question_id': 9,
      'answer_text': "c.	Pencabutan ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 36,
      'question_id': 9,
      'answer_text': "d.	Menyikat gigi ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 37,
      'question_id': 10,
      'answer_text': "a.	Karies gigi ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 38,
      'question_id': 10,
      'answer_text': "b.	Karang gigi ",
      'isTrue': 1
    });
    batch.insert("answer_keluarga", {
      'id': 39,
      'question_id': 10,
      'answer_text': "c.	Gigi berjejel ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga", {
      'id': 40,
      'question_id': 10,
      'answer_text': "d.	Gigi keropos ",
      'isTrue': 0
    });
    batch.insert("answer_keluarga",
        {'id': 41, 'question_id': 11, 'answer_text': "benar", 'isTrue': 1});
    batch.insert("answer_keluarga",
        {'id': 42, 'question_id': 11, 'answer_text': "salah", 'isTrue': 0});
    batch.insert("answer_keluarga",
        {'id': 43, 'question_id': 12, 'answer_text': "benar", 'isTrue': 0});
    batch.insert("answer_keluarga",
        {'id': 44, 'question_id': 12, 'answer_text': "salah", 'isTrue': 1});
    batch.insert("answer_keluarga",
        {'id': 45, 'question_id': 13, 'answer_text': "benar", 'isTrue': 0});
    batch.insert("answer_keluarga",
        {'id': 46, 'question_id': 13, 'answer_text': "salah", 'isTrue': 1});
    batch.insert("answer_keluarga",
        {'id': 47, 'question_id': 14, 'answer_text': "benar", 'isTrue': 1});
    batch.insert("answer_keluarga",
        {'id': 48, 'question_id': 14, 'answer_text': "salah", 'isTrue': 0});
    batch.insert("answer_keluarga",
        {'id': 49, 'question_id': 15, 'answer_text': "benar", 'isTrue': 1});
    batch.insert("answer_keluarga",
        {'id': 50, 'question_id': 15, 'answer_text': "salah", 'isTrue': 0});
    batch.insert("answer_keluarga",
        {'id': 51, 'question_id': 16, 'answer_text': "benar", 'isTrue': 0});
    batch.insert("answer_keluarga",
        {'id': 52, 'question_id': 16, 'answer_text': "salah", 'isTrue': 1});
    batch.insert("answer_keluarga",
        {'id': 53, 'question_id': 17, 'answer_text': "benar", 'isTrue': 0});
    batch.insert("answer_keluarga",
        {'id': 54, 'question_id': 17, 'answer_text': "salah", 'isTrue': 1});
    batch.insert("answer_keluarga",
        {'id': 55, 'question_id': 18, 'answer_text': "benar", 'isTrue': 1});
    batch.insert("answer_keluarga",
        {'id': 56, 'question_id': 18, 'answer_text': "salah", 'isTrue': 0});
    batch.insert("answer_keluarga",
        {'id': 57, 'question_id': 19, 'answer_text': "benar", 'isTrue': 1});
    batch.insert("answer_keluarga",
        {'id': 58, 'question_id': 19, 'answer_text': "salah", 'isTrue': 0});
    batch.insert("answer_keluarga",
        {'id': 59, 'question_id': 20, 'answer_text': "benar", 'isTrue': 1});
    batch.insert("answer_keluarga",
        {'id': 60, 'question_id': 20, 'answer_text': "salah", 'isTrue': 0});
    await batch.commit(noResult: true);
  }

  Future<void> _createDefaultAnswerLansia(Database database) async {
    Batch batch = database.batch();
    batch.insert("answer_lansia", {
      'id': 1,
      'question_id': 1,
      'answer_text': "a.	Kumur-kumur",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 2,
      'question_id': 1,
      'answer_text': "b.	Menggosok gigi",
      'isTrue': 1
    });
    batch.insert("answer_lansia", {
      'id': 3,
      'question_id': 1,
      'answer_text': "c.	Menambal gigi",
      'isTrue': 0
    });
    batch.insert("answer_lansia",
        {'id': 4, 'question_id': 1, 'answer_text': "d.	Mandi ", 'isTrue': 0});
    batch.insert("answer_lansia", {
      'id': 5,
      'question_id': 2,
      'answer_text': "a.	Sikat gigi saja",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 6,
      'question_id': 2,
      'answer_text': "b.	Sikat gigi dan obat kumur",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 7,
      'question_id': 2,
      'answer_text': "c.	Sikat gigi dan pasta gigi",
      'isTrue': 1
    });
    batch.insert("answer_lansia", {
      'id': 8,
      'question_id': 2,
      'answer_text': "d.	Pasta gigi dan obat kumur",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 9,
      'question_id': 3,
      'answer_text': "a.	Buah dan sayur yang mengandung serat",
      'isTrue': 1
    });
    batch.insert("answer_lansia", {
      'id': 10,
      'question_id': 3,
      'answer_text': "b.	Makanan yang hambar",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 11,
      'question_id': 3,
      'answer_text': "c.	Makanan yang lezat",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 12,
      'question_id': 3,
      'answer_text': "d.	Makanan yang mahal",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 13,
      'question_id': 4,
      'answer_text': "a.	Satu kali",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 14,
      'question_id': 4,
      'answer_text': "b.	Tidak pernah",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 15,
      'question_id': 4,
      'answer_text': "c.	Dua kali",
      'isTrue': 1
    });
    batch.insert("answer_lansia", {
      'id': 16,
      'question_id': 4,
      'answer_text': "d.	Setiap sehabis makan",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 17,
      'question_id': 5,
      'answer_text': "a.	Malam hari",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 18,
      'question_id': 5,
      'answer_text': "b.	Mandi pagi",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 19,
      'question_id': 5,
      'answer_text': "c.	Pagi sesudah sarapan dan malam sebelum tidur",
      'isTrue': 1
    });
    batch.insert("answer_lansia", {
      'id': 20,
      'question_id': 5,
      'answer_text': "d.	Pagi sesudah sarapan",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 21,
      'question_id': 6,
      'answer_text': "a.	3 bulan satu kali",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 22,
      'question_id': 6,
      'answer_text': "b.	6 bulan sekali",
      'isTrue': 1
    });
    batch.insert("answer_lansia", {
      'id': 23,
      'question_id': 6,
      'answer_text': "c.	1 bulan sekali",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 24,
      'question_id': 6,
      'answer_text': "d.	1 tahun sekali",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 25,
      'question_id': 7,
      'answer_text':
      "a.	Menggosok gigi pagi sesudah sarapan dan malam sebelum tidur",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 26,
      'question_id': 7,
      'answer_text': "b.	Berkumur-kumur ",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 27,
      'question_id': 7,
      'answer_text': "c.	Menggunakan sikat gigi dan pasta gigi",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 28,
      'question_id': 7,
      'answer_text': "d.	 Menggunakan sikat gigi bersama-sama",
      'isTrue': 1
    });
    batch.insert("answer_lansia", {
      'id': 29,
      'question_id': 8,
      'answer_text': "a.	Bulat-bulat",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 30,
      'question_id': 8,
      'answer_text': "b.	Maju mundur",
      'isTrue': 1
    });
    batch.insert("answer_lansia", {
      'id': 31,
      'question_id': 8,
      'answer_text': "c.	Mencongkel ",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 32,
      'question_id': 8,
      'answer_text': "d.	 Naik turun",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 33,
      'question_id': 9,
      'answer_text': "a.	Yang bewarna-warni",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 34,
      'question_id': 9,
      'answer_text': "b.	Yang mengandung fluor",
      'isTrue': 1
    });
    batch.insert("answer_lansia", {
      'id': 35,
      'question_id': 9,
      'answer_text': "c.	Yang mahal",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 36,
      'question_id': 9,
      'answer_text': "d.	Yang wangi",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 37,
      'question_id': 10,
      'answer_text': "a.	Gigi mudah berdarah",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 38,
      'question_id': 10,
      'answer_text': "b.	Gigi cepat tanggal ",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 39,
      'question_id': 10,
      'answer_text': "c.	Sariawan ",
      'isTrue': 0
    });
    batch.insert("answer_lansia", {
      'id': 40,
      'question_id': 10,
      'answer_text': "d.	Gigi mudah berlubang",
      'isTrue': 1
    });
    batch.insert("answer_lansia",
        {'id': 41, 'question_id': 11, 'answer_text': "setuju", 'isTrue': 1});
    batch.insert("answer_lansia",
        {'id': 42, 'question_id': 11, 'answer_text': "tidak", 'isTrue': 0});
    batch.insert("answer_lansia",
        {'id': 43, 'question_id': 12, 'answer_text': "setuju", 'isTrue': 1});
    batch.insert("answer_lansia",
        {'id': 44, 'question_id': 12, 'answer_text': "tidak", 'isTrue': 0});
    batch.insert("answer_lansia",
        {'id': 45, 'question_id': 13, 'answer_text': "setuju", 'isTrue': 0});
    batch.insert("answer_lansia",
        {'id': 46, 'question_id': 13, 'answer_text': "tidak", 'isTrue': 1});
    batch.insert("answer_lansia",
        {'id': 47, 'question_id': 14, 'answer_text': "setuju", 'isTrue': 1});
    batch.insert("answer_lansia",
        {'id': 48, 'question_id': 14, 'answer_text': "tidak", 'isTrue': 0});
    batch.insert("answer_lansia",
        {'id': 49, 'question_id': 15, 'answer_text': "setuju", 'isTrue': 1});
    batch.insert("answer_lansia",
        {'id': 50, 'question_id': 15, 'answer_text': "tidak", 'isTrue': 0});
    batch.insert("answer_lansia",
        {'id': 51, 'question_id': 16, 'answer_text': "setuju", 'isTrue': 0});
    batch.insert("answer_lansia",
        {'id': 52, 'question_id': 16, 'answer_text': "tidak", 'isTrue': 1});
    batch.insert("answer_lansia",
        {'id': 53, 'question_id': 17, 'answer_text': "setuju", 'isTrue': 1});
    batch.insert("answer_lansia",
        {'id': 54, 'question_id': 17, 'answer_text': "tidak", 'isTrue': 0});
    batch.insert("answer_lansia",
        {'id': 55, 'question_id': 18, 'answer_text': "setuju", 'isTrue': 0});
    batch.insert("answer_lansia",
        {'id': 56, 'question_id': 18, 'answer_text': "tidak", 'isTrue': 1});
    batch.insert("answer_lansia",
        {'id': 57, 'question_id': 19, 'answer_text': "setuju", 'isTrue': 0});
    batch.insert("answer_lansia",
        {'id': 58, 'question_id': 19, 'answer_text': "tidak", 'isTrue': 1});
    batch.insert("answer_lansia",
        {'id': 59, 'question_id': 20, 'answer_text': "setuju", 'isTrue': 0});
    batch.insert("answer_lansia",
        {'id': 60, 'question_id': 20, 'answer_text': "tidak", 'isTrue': 1});

    await batch.commit(noResult: true);
  }

  Future<void> _createDefaultTindakanChecklist(Database database) async {
    Batch batch = database.batch();
    batch.insert("tindakan", {
      'id': 1,
      'type': 0,
      'text': "1. Keluarga mengajak lansia melakukan kegiatan menggosok gigi"
    });
    batch.insert("tindakan", {
      'id': 2,
      'type': 0,
      'text': "2. Keluarga mendampingi lansia dalam kegiatan menggosok gigi"
    });
    batch.insert("tindakan", {
      'id': 3,
      'type': 0,
      'text': "3. Keluarga memberi motivasi kepada lansia dalam menjaga kebersihan gigi dan mulut"
    });
    batch.insert("tindakan", {
      'id': 4,
      'type': 0,
      'text': "4. Keluarga memberikan nasihat kepada lansia larangan dalam mengkonsumsi makanan dan minuman yang merusak gigi"
    });
    batch.insert("tindakan", {
      'id': 5,
      'type': 0,
      'text': "5. Keluarga memberikan contoh cara menggosok gigi yang baik dan benar pada lansia"
    });
    batch.insert("tindakan", {
      'id': 6,
      'type': 0,
      'text': "6. Keluarga melakukan diet gula untuk menjaga kesehatan gigi dan mulut lansia"
    });
    batch.insert("tindakan", {
      'id': 7,
      'type': 0,
      'text': "7. Keluarga melakukan kontrol rutin kesehatan gigi dan mulut lansia ke palayanan kesehatan"
    });
    batch.insert("tindakan", {
      'id': 8,
      'type': 1,
      'text': "1. Menyiapkan sikat gigi dan pasta gigi"
    });
    batch.insert("tindakan", {
      'id': 9,
      'type': 1,
      'text': "2. Menggunakan pasta gigi sebutir kacang tanah"
    });
    batch.insert("tindakan", {
      'id': 10,
      'type': 1,
      'text': "3. Berkumur-kumur dengan air bersih sebelum menggosok gigi"
    });
    batch.insert("tindakan", {
      'id': 11,
      'type': 1,
      'text': "4. Permukaan gigi bagian pipi kanan dan kiri disikat dengan gerakan memutar pendek-pendek"
    });
    batch.insert("tindakan", {
      'id': 12,
      'type': 1,
      'text': "5. Permukaan gigi depan disatukan disikat dengan gerakan memutar"
    });
    batch.insert("tindakan", {
      'id': 13,
      'type': 1,
      'text': "6. Permukaan bagian dalam gigi rahang bawah miringkan sikat gigi seperti dalam gerakan mencongkel"
    });
    batch.insert("tindakan", {
      'id': 14,
      'type': 1,
      'text': "7. Permukaan kunyah gigi atas dan bawah dengan gerakan lembut maju mundur"
    });
    batch.insert("tindakan", {
      'id': 15,
      'type': 1,
      'text': "8. Menggosok lidah dengan gerakan maju mundur"
    });
    batch.insert("tindakan", {
      'id': 16,
      'type': 1,
      'text': "9. Mengakhiri menggosok gigi dengan berkumur-kumur air bersih"
    });
    batch.insert("tindakan", {
      'id': 17,
      'type': 1,
      'text': "10. Membersihkan sikat gigi setelah selesai menggosok gigi"
    });

    await batch.commit(noResult: true);
  }

}
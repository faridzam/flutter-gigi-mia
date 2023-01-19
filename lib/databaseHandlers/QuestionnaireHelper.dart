import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io' as io;

import '../models/TindakanMasterModel.dart';
import '../models/TindakanUserModel.dart';
import '../models/QuestionnaireAnswerModel.dart';

class QuestionnaireHelper{
  static Database? _db;

  static const String DB_Name = 'pengasuh_gigi.db';
  static const String Table_Master = 'tindakan';
  static const String Table_User = 'tindakan_user';
  static const int version = 1;

  static const String C_Id = 'id';
  static const String C_Text = 'text';
  static const String C_Type = 'type';
  static const String C_UserID = 'user_id';
  static const String C_TindakanID = 'tindakan_id';

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
    var db = await openDatabase(path, version: version, onCreate: _onCreate, onOpen: _onOpen);
    return db;
  }

  _onCreate(Database db, int intVersion) async{
    print('Create Database');
    await db.execute("CREATE TABLE $Table_Master ("
        "$C_Id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$C_Type INTEGER, "
        "$C_Text TEXT "
        ")"
    );
    await db.execute("CREATE TABLE $Table_User ("
        "$C_Id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$C_UserID INTEGER, "
        "$C_TindakanID INTEGER, "
        "$C_Type INTEGER, "
        "$C_Text TEXT "
        ")"
    );
  }
  _onOpen(Database db) async{
    print('Open Database');
  }

  Future<TindakanMasterModel> getQuestionByID(id) async {
    // Get a reference to the database.
    var dbclient = await db;

    // Query the table for all the Breeds.
    final List<Map<String, dynamic>> maps = await dbclient!.query(
        Table_Master,
        where: "id = ?",
        whereArgs: [id],
        limit: 1
    );

    return TindakanMasterModel.fromMap(maps[0]);

  }

  Future<List<QuestionnaireAnswerModel>> getAnswer() async {
    // Get a reference to the database.
    var dbclient = await db;

    // Query the table for all the Breeds.
    final List<Map<String, dynamic>> maps = [{'value': 1, 'answer_text': 'Benar'}, {'value': 0, 'answer_text': 'Salah'}];

    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return List.generate(maps.length, (index) => QuestionnaireAnswerModel.fromMap(maps[index]));
  }

  Future<int> insertTindakanUserKeluarga(tindakan) async{
    var dbClient = await db;

    final prefs = await SharedPreferences.getInstance();
    final int? _id = prefs.getInt('id');

    for (var i=0; i < tindakan.length; i++) {
      var res = await dbClient!.insert(Table_User, TindakanUserModel(_id!, i+1, 0, tindakan[i]).toMap());
      print(res);
    }

    return 1;
  }
  Future<int> insertTindakanUserLansia(tindakan) async{
    var dbClient = await db;

    final prefs = await SharedPreferences.getInstance();
    final int? _id = prefs.getInt('id');

    for (var i=0; i < tindakan.length; i++) {
      var res = await dbClient!.insert(Table_User, TindakanUserModel(_id!, i+8, 1, tindakan[i]).toMap());
      print(res);
    }

    return 1;
  }


}
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io' as io;

import '../models/PretestModel.dart';

class PretestHelper{
  static Database? _db;

  static const String DB_Name = 'pengasuh_gigi.db';
  static const String Table = 'pretest';
  static const int version = 1;

  static const String C_Id = 'id';
  static const String C_UserID = 'user_id';
  static const String C_Type = 'type';
  static const String C_Score = 'score';

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
    await db.execute("CREATE TABLE $Table ("
        "$C_Id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$C_UserID INTEGER, "
        "$C_Type INTEGER, "
        "$C_Score INTEGER "
        ")"
    );
  }
  _onOpen(Database db) async{
    print('Open Database');
  }

  Future<int> insertPretest(PretestModel pretest) async{
    var dbClient = await db;
    var res = await dbClient!.insert(Table, pretest.toMap());
    return res;
  }

  // A method that retrieves all the breeds from the breeds table.
  Future<List<PretestModel>> getPretest() async {
    // Get a reference to the database.
    var dbclient = await db;

    // var currentMonth = new DateTime.now().month;

    // var taskCategory;
    //
    // if(1 <= currentMonth && currentMonth <= 3){
    //   taskCategory = 1;
    // }else if(4 <= currentMonth && currentMonth <= 6){
    //   taskCategory = 2;
    // }else if(7 <= currentMonth && currentMonth <= 9){
    //   taskCategory = 3;
    // } else {
    //   taskCategory = 4;
    // }

    // Query the table for all the Breeds.
    final List<Map<String, dynamic>> maps = await dbclient!.query(Table, columns: [C_Id, C_UserID, C_Score]);
    // final List<Map<String, dynamic>> maps = await dbclient!.query(Table, columns: [C_Id, C_Category, C_Name, C_Description], where:'$C_Category = ?', whereArgs: [taskCategory]);

    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return List.generate(maps.length, (index) => PretestModel.fromMap(maps[index]));
  }

  Future<List<PretestModel?>> getScoreUser() async {
    var dbclient = await db;
    final prefs = await SharedPreferences.getInstance();
    final int? _id = prefs.getInt('id');
    List<PretestModel> result = [];
    final List<Map<String, dynamic>> dataKeluarga = await dbclient!.query(Table, columns: [C_Id, C_UserID, C_Type, C_Score], where:'$C_UserID = ? and $C_Type = ?', whereArgs: [_id, 0]);
    final List<Map<String, dynamic>> dataLansia = await dbclient.query(Table, columns: [C_Id, C_UserID, C_Type, C_Score], where:'$C_UserID = ? and $C_Type = ?', whereArgs: [_id, 1]);
    result.add(PretestModel(dataKeluarga.last["user_id"], dataKeluarga.last['type'], dataKeluarga.last['score']));
    result.add(PretestModel(dataLansia.last["user_id"], dataLansia.last['type'], dataLansia.last['score']));

    print(dataKeluarga);
    print(dataLansia);
    print(result);
    return result;
  }

  Future<PretestModel?> getScoreKeluarga() async {
    var dbclient = await db;
    final prefs = await SharedPreferences.getInstance();
    final int? _id = prefs.getInt('id');
    final List<Map<String, dynamic>> dataKeluarga = await dbclient!.query(Table, columns: [C_Id, C_UserID, C_Type, C_Score], where:'$C_UserID = ? and $C_Type = ?', whereArgs: [_id, 0]);
    final PretestModel lastData = PretestModel(dataKeluarga.last["user_id"], dataKeluarga.last['type'], dataKeluarga.last['score']);

    return lastData;
  }
  Future<PretestModel?> getScoreLansia() async {
    var dbclient = await db;
    final prefs = await SharedPreferences.getInstance();
    final int? _id = prefs.getInt('id');
    final List<Map<String, dynamic>> dataLansia = await dbclient!.query(Table, columns: [C_Id, C_UserID, C_Type, C_Score], where:'$C_UserID = ? and $C_Type = ?', whereArgs: [_id, 1]);
    final PretestModel lastData = PretestModel(dataLansia.last["user_id"], dataLansia.last['type'], dataLansia.last['score']);

    return lastData;
  }

}
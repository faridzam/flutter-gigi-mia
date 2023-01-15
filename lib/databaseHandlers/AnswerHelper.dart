import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io' as io;

import '../models/AnswerModel.dart';

class AnswerHelper{
  static Database? _db;

  static const String DB_Name = 'pengasuh_gigi.db';
  static const String Table_Keluarga = 'answer_keluarga';
  static const String Table_Lansia = 'answer_lansia';
  static const int version = 1;

  static const String C_Id = 'id';
  static const String C_QuestionID = 'question_id';
  static const String C_AnswerText = 'answer_text';
  static const String C_IsTrue = 'isTrue';

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
    await db.execute("CREATE TABLE $Table_Keluarga ("
        "$C_Id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$C_QuestionID INTEGER, "
        "$C_AnswerText TEXT, "
        "$C_IsTrue INtEGER "
        ")"
    );
    await db.execute("CREATE TABLE $Table_Lansia ("
        "$C_Id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$C_QuestionID INTEGER, "
        "$C_AnswerText TEXT, "
        "$C_IsTrue INtEGER "
        ")"
    );
  }
  _onOpen(Database db) async{
    print('Open Database');
  }

  // Future<int> insertAnswer(AnswerModel answer) async{
  //   var dbClient = await db;
  //   var res = await dbClient!.insert(Table, answer.toMap());
  //   return res;
  // }

  Future<List<Map<Object, dynamic>>> getAnswerMapListKeluarga() async {
    var dbclient = await db;
    var result = await dbclient!.rawQuery('SELECT * FROM "$Table_Keluarga"');

    return List<Map<Object, dynamic>>.generate(
        result.length, (index) => Map<Object, dynamic>.from(result[index]),
        growable: true
    );

    //return result.toList();
  }
  Future<List<Map<Object, dynamic>>> getAnswerMapListLansia() async {
    var dbclient = await db;
    var result = await dbclient!.rawQuery('SELECT * FROM "$Table_Lansia"');

    return List<Map<Object, dynamic>>.generate(
        result.length, (index) => Map<Object, dynamic>.from(result[index]),
        growable: true
    );

    //return result.toList();
  }

  // A method that retrieves all the breeds from the breeds table.
  Future<List<AnswerModel>> getAnswerKeluarga() async {
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
    final List<Map<String, dynamic>> maps = await dbclient!.query(Table_Keluarga, columns: [C_Id, C_QuestionID, C_AnswerText, C_IsTrue]);
    // final List<Map<String, dynamic>> maps = await dbclient!.query(Table, columns: [C_Id, C_Category, C_Name, C_Description], where:'$C_Category = ?', whereArgs: [taskCategory]);

    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return List.generate(maps.length, (index) => AnswerModel.fromMap(maps[index]));
  }
  Future<List<AnswerModel>> getAnswerLansia() async {
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
    final List<Map<String, dynamic>> maps = await dbclient!.query(Table_Lansia, columns: [C_Id, C_QuestionID, C_AnswerText, C_IsTrue]);
    // final List<Map<String, dynamic>> maps = await dbclient!.query(Table, columns: [C_Id, C_Category, C_Name, C_Description], where:'$C_Category = ?', whereArgs: [taskCategory]);

    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return List.generate(maps.length, (index) => AnswerModel.fromMap(maps[index]));
  }

  Future<List<AnswerModel>> getAnswerAllKeluarga() async {
    // Get a reference to the database.
    var dbclient = await db;

    // Query the table for all the Breeds.
    final List<Map<String, dynamic>> maps = await dbclient!.query(Table_Keluarga);

    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return List.generate(maps.length, (index) => AnswerModel.fromMap(maps[index]));
  }
  Future<List<AnswerModel>> getAnswerAllLansia() async {
    // Get a reference to the database.
    var dbclient = await db;

    // Query the table for all the Breeds.
    final List<Map<String, dynamic>> maps = await dbclient!.query(Table_Lansia);

    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return List.generate(maps.length, (index) => AnswerModel.fromMap(maps[index]));
  }

  Future<List<AnswerModel>> getAnswerByIDKeluarga(id) async {
    // Get a reference to the database.
    var dbclient = await db;

    // Query the table for all the Breeds.
    final List<Map<String, dynamic>> maps = await dbclient!.query(
        Table_Keluarga,
        where: "question_id = ?",
        whereArgs: [id],
    );

    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return List.generate(maps.length, (index) => AnswerModel.fromMap(maps[index]));
  }
  Future<List<AnswerModel>> getAnswerByIDLansia(id) async {
    // Get a reference to the database.
    var dbclient = await db;

    // Query the table for all the Breeds.
    final List<Map<String, dynamic>> maps = await dbclient!.query(
        Table_Lansia,
        where: "question_id = ?",
        whereArgs: [id],
    );

    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return List.generate(maps.length, (index) => AnswerModel.fromMap(maps[index]));
  }

  Future<int> getCorrectAnswer(answered) async {
    // Get a reference to the database.
    var dbclient = await db;

    // Query the table for all the Breeds.
    final List<Map<String, dynamic>> maps = await dbclient!.query(
      Table_Lansia,
      where: "id IN (${List.filled(answered.length, '?').join(',')}) and isTrue = ?",
      whereArgs: [answered, 1],
    );

    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return maps.length;
  }

}
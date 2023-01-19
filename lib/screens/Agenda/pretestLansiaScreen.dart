import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gigi_mia/screens/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gigi_mia/models/AnswerModel.dart';
import 'package:gigi_mia/models/PretestModel.dart';
import 'package:gigi_mia/models/QuestionModel.dart';
import '../../databaseHandlers/AnswerHelper.dart';
import '../../databaseHandlers/QuestionHelper.dart';
import '../../databaseHandlers/QuestionnaireHelper.dart';
import 'package:gigi_mia/databaseHandlers/PretestHelper.dart';

class PretestLansiaScreen extends StatefulWidget {
  const PretestLansiaScreen({Key? key}) : super(key: key);

  @override
  State<PretestLansiaScreen> createState() => _PretestLansiaScreenState();
}

class _PretestLansiaScreenState extends State<PretestLansiaScreen> {

  var dbHelperQuestion;
  var dbHelperAnswer;
  var dbHelperPretest;
  var dbHelperQuestionnaire;

  var questionID;
  var questionnaireID;
  var questionText;
  var answers;
  var answeredListArray;
  var tindakanListArray;

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  int user_id = 0;
  String username = "";
  String phone = "";
  String email = "";

  Future<void> getUserData() async{
    final SharedPreferences sp = await _pref;

    setState((){
      user_id = sp.getInt("id")!;
      username = sp.getString("username")!;
      phone = sp.getString("phone")!;
      email = sp.getString("email")!;
    });
  }

  @override
  void initState() {
    super.initState();
    dbHelperQuestion = QuestionHelper();
    dbHelperAnswer = AnswerHelper();
    dbHelperPretest = PretestHelper();
    dbHelperQuestionnaire = QuestionnaireHelper();
    questionID = 1;
    questionnaireID = 8;
    questionText = "";
    answers = [];
    answeredListArray = [];
    tindakanListArray = [];
    getQuestionByID(questionID);
    getAnswersByID(questionID);
    getUserData();
  }

  getQuestionByID(id) async {
    await dbHelperQuestion.getQuestionByIDLansia(id).then((question){
      setState((){
        questionText = question.question_text;
      });
    }).catchError((error){
      print(error);
    });
  }

  getAnswersByID(id) async {
    await dbHelperAnswer.getAnswerByIDLansia(id).then((listAnswer){
      setState((){
        answers = listAnswer;
      });
    }).catchError((error){
      print(error);
    });
  }
  getQuestionnaireByID(id) async {
    await dbHelperQuestionnaire.getQuestionByID(id).then((question){
      setState((){
        questionText = question.text;
      });
    }).catchError((error){
      print(error);
    });
  }

  getAnswers() async {
    await dbHelperQuestionnaire.getAnswer().then((listAnswer){
      setState((){
        answers = listAnswer;
      });
    }).catchError((error){
      print(error);
    });
  }

  submit() async {
    //
    setState((){
      answeredListArray.add(1);
    });
    await dbHelperAnswer.getCorrectAnswerLansia(answeredListArray).then((response) async{
      var score = response/20*100;
      print(score);

      await dbHelperPretest.insertPretest(PretestModel(user_id, 1, score.toInt())).then((response) {
        print(response);
      });
    });

    await dbHelperQuestionnaire.insertTindakanUserLansia(tindakanListArray).then((response) async{
      print(response);
    });

    Fluttertoast.showToast(
        msg: "answers submited",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
            (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pretest Lansia"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                questionText,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              SizedBox(
                height: 20,
              ),
              for(var answer in answers)
                Container(
                  height: 50,
                  width: 300,
                  child: OutlinedButton(
                      onPressed: () {
                        if(questionID < 20) {
                          setState((){
                            answeredListArray.add(answer.id);
                          });

                          setState(() {
                            questionID += 1;
                          });
                          getQuestionByID(questionID);
                          getAnswersByID(questionID);
                          print(answeredListArray);
                          print(tindakanListArray);
                        } else if(questionID == 20){
                          setState((){
                            answeredListArray.add(answer.id);
                          });
                          setState(() {
                            questionID += 1;
                          });
                          getQuestionnaireByID(questionnaireID);
                          getAnswers();
                          print(answeredListArray);
                          print(tindakanListArray);
                        } else if(questionnaireID < 17){
                          setState((){
                            tindakanListArray.add(answer.value);
                          });
                          setState(() {
                            questionnaireID += 1;
                          });
                          getQuestionnaireByID(questionnaireID);
                          getAnswers();
                          print(answeredListArray);
                          print(tindakanListArray);
                        } else if(questionnaireID == 17){
                          setState((){
                            tindakanListArray.add(answer.value);
                          });
                          setState(() {
                            questionnaireID += 1;
                          });

                          print(answeredListArray);
                          print(tindakanListArray);

                          submit();
                        }
                      },
                      child: Text(answer.answer_text)
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gigi_mia/models/AnswerModel.dart';
import 'package:gigi_mia/models/PretestModel.dart';
import 'package:gigi_mia/models/QuestionModel.dart';
import '../../databaseHandlers/AnswerHelper.dart';
import '../../databaseHandlers/QuestionHelper.dart';
import '../../databaseHandlers/QuestionnaireHelper.dart';
import 'package:gigi_mia/databaseHandlers/PretestHelper.dart';

class PretestKeluargaScreen extends StatefulWidget {
  const PretestKeluargaScreen({Key? key}) : super(key: key);

  @override
  State<PretestKeluargaScreen> createState() => _PretestKeluargaScreenState();
}

class AnswerItem {
  int question_id;
  int answer_id;

  AnswerItem(this.question_id, this.answer_id);
}

class AnswerList {
  List<AnswerItem> items = [];
}

class _PretestKeluargaScreenState extends State<PretestKeluargaScreen> {

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

  @override
  void initState() {
    super.initState();
    dbHelperQuestion = QuestionHelper();
    dbHelperAnswer = AnswerHelper();
    dbHelperPretest = PretestHelper();
    dbHelperQuestionnaire = QuestionnaireHelper();
    questionID = 1;
    questionnaireID = 1;
    questionText = "";
    answers = [];
    answeredListArray = [];
    tindakanListArray = [];
    getQuestionByID(questionID);
    getAnswersByID(questionID);
  }

  getQuestionByID(id) async {
    await dbHelperQuestion.getQuestionByIDKeluarga(id).then((question){
      setState((){
        questionText = question.question_text;
      });
    }).catchError((error){
      print(error);
    });
  }

  getAnswersByID(id) async {
    await dbHelperAnswer.getAnswerByIDKeluarga(id).then((listAnswer){
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
    await dbHelperAnswer.getCorrectAnswer(answeredListArray).then((response) {
      print(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pretest Keluarga"),
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
                        } else if(questionnaireID < 7){
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
                        } else if(questionnaireID == 7){
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

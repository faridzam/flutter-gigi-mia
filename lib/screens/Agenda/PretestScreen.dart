import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';

import 'package:gigi_mia/models/AnswerModel.dart';
import 'package:gigi_mia/models/PretestModel.dart';
import 'package:gigi_mia/models/QuestionModel.dart';
import '../../databaseHandlers/AnswerHelper.dart';
import '../../databaseHandlers/QuestionHelper.dart';
import 'package:gigi_mia/databaseHandlers/PretestHelper.dart';

class PretestScreen extends StatefulWidget {
  const PretestScreen({Key? key}) : super(key: key);

  @override
  State<PretestScreen> createState() => _PretestScreenState();
}

class AnswerItem {
  int question_id;
  int answer_id;

  AnswerItem(this.question_id, this.answer_id);
}

class AnswerList {
  List<AnswerItem> items = [];
}

class _PretestScreenState extends State<PretestScreen> {

  final LocalStorage storage = new LocalStorage('answer_list');

  var dbHelperQuestion;
  var dbHelperAnswer;
  var dbHelperPretest;

  var questionID;
  var questionText;
  var answers;

  @override
  void initState() {
    super.initState();
    dbHelperQuestion = QuestionHelper();
    dbHelperAnswer = AnswerHelper();
    dbHelperPretest = PretestHelper();
    questionID = 1;
    questionText = "";
    answers = [];
    storage.setItem("answered_list", []);
    getQuestionByID(questionID);
    getAnswersByID(questionID);
  }

  getQuestionByID(id) async {
    await dbHelperQuestion.getQuestionByID(id).then((question){
      setState((){
        questionText = question.question_text;
      });
    }).catchError((error){
      print(error);
    });
  }

  getAnswersByID(id) async {
    await dbHelperAnswer.getAnswerByID(id).then((listAnswer){
      setState((){
        answers = listAnswer;
      });
    }).catchError((error){
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pretest"),
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
                      var answeredListArray = storage.getItem("answered_list");
                      answeredListArray.add(answer.id);
                      storage.setItem("answered_list", answeredListArray);
                      // storage.setItem("$questionID", answer.id);
                      setState((){
                        questionID+=1;
                      });
                      getQuestionByID(questionID);
                      getAnswersByID(questionID);
                      print(storage.getItem("answered_list"));
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

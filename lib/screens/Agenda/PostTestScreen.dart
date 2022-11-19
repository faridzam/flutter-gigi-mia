import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gigi_mia/databaseHandlers/PostTestHelper.dart';

import 'package:gigi_mia/models/AnswerModel.dart';
import 'package:gigi_mia/models/PostTestModel.dart';
import 'package:gigi_mia/models/QuestionModel.dart';
import 'package:gigi_mia/screens/Agenda/PretestScoreScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../databaseHandlers/AnswerHelper.dart';
import '../../databaseHandlers/QuestionHelper.dart';

class PostTestScreen extends StatefulWidget {
  const PostTestScreen({Key? key}) : super(key: key);

  @override
  State<PostTestScreen> createState() => _PostTestScreenState();
}

class _PostTestScreenState extends State<PostTestScreen> {

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  int user_id = 0;

  Future<void> getUserData() async{
    final SharedPreferences sp = await _pref;

    setState((){
      user_id = sp.getInt("id")!;
    });
  }

  var dbHelperQuestion;
  var dbHelperAnswer;
  var dbHelperPostTest;

  int? _conQuestion1 = 0;
  int? _conQuestion2 = 0;

  late List<QuestionModel> questions = [];
  late List<AnswerModel> answers = [];

  @override
  void initState() {
    super.initState();
    dbHelperQuestion = QuestionHelper();
    dbHelperAnswer = AnswerHelper();
    dbHelperPostTest = PostTestHelper();
    getQuestionAnswer();
    getUserData();
    ifScoreExist();
  }

  Future getQuestionAnswer() async{
    await dbHelperQuestion.getQuestion().then((items) {
      if(items != null){
        setState((){
          questions = items;
        });
        questions.shuffle();
      } else{
        Fluttertoast.showToast(
            msg: "Question not found!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    });
    await dbHelperAnswer.getAnswer().then((items) {
      if(items != null){
        setState((){
          answers = items;
        });
        answers.shuffle();
      } else{
        Fluttertoast.showToast(
            msg: "answers not found!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    });
  }

  genAnswer(question_id){
    List<Widget> list = <Widget>[];
    var group;
    if(question_id == 1){
      group = _conQuestion1;
    } else if (question_id == 2){
      group = _conQuestion2;
    }
    list.add(
        new Container(
          child: Column(
            children: [
              for(var answer in answers)
                if(answer.question_id == question_id)
                  RadioListTile(
                    title: Text(answer.answer_text.toString()),
                    value: answer.id,
                    groupValue: group,
                    onChanged: (value){
                      _handleRadioValueChange(value as int, question_id);
                    },
                  ),
            ],
          ),
        )
    );
    return new Column(children: list,);
  }

  genQuestion()
  {
    List<Widget> list = <Widget>[];
    for(var question in questions){
      list.add(new Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Center(
          child: Text(
            question.question_text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ));
      list.add(genAnswer(question.id));
    }
    return new Column(children: list);
  }

  submit() async {
    List<int?> answered = [_conQuestion1, _conQuestion2];
    List _true = answers.where((element) => answered.contains(element.id) && element.isTrue == 1).toList();

    var score = (_true.length / answered.length)*100;

    print(answered);
    print(_true);
    print(score);

    PostTestModel postTestModel = PostTestModel(user_id, score.toInt());
    await dbHelperPostTest.insertPostTest(postTestModel).then((postTestData) {
      Fluttertoast.showToast(
          msg: "post-test finished successfully!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (_)=> PretestScoreScreen()), (Route<dynamic> route) => false
      );

    }).catchError((error){
      print(error);
      // alertDialog("Error: save data failed!");
      Fluttertoast.showToast(
          msg: "Error: save data failed!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });

  }

  ifScoreExist() async{
    //
    await dbHelperPostTest.getScoreUser().then((postTestData) {

      if(postTestData != null){
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_)=> PretestScoreScreen()), (Route<dynamic> route) => true
        );
      }

    }).catchError((error){
      print(error);
      return null;
    });
  }

  void _handleRadioValueChange(int value, int groupValue) {

    print(value);
    print(groupValue);
    if(groupValue == 1){
      setState(() {
        _conQuestion1 = value;
      });
    } else if(groupValue == 2){
      setState(() {
        _conQuestion2 = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("ini post-test"),
        ),
        body: Container(
          child: SingleChildScrollView(
              child: Column(
                children: [
                  genQuestion(),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: TextButton.icon(
                      onPressed: submit,
                      icon: const Icon(
                        Icons.login_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "submit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}

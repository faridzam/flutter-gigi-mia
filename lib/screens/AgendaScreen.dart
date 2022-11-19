import 'package:flutter/material.dart';
import 'package:gigi_mia/databaseHandlers/PostTestHelper.dart';
import 'package:gigi_mia/databaseHandlers/PretestHelper.dart';
import 'package:gigi_mia/screens/Agenda/MateriScreen.dart';
import 'package:gigi_mia/screens/Agenda/PostTestScreen.dart';
import 'package:gigi_mia/screens/Agenda/PretestScoreScreen.dart';
import 'package:gigi_mia/screens/Agenda/PretestScreen.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({Key? key}) : super(key: key);

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {

  var dbHelperPretest;
  var dbHelperPostTest;
  late bool pretestStatus = false;
  late bool postTestStatus = false;

  @override
  void initState() {
    super.initState();
    dbHelperPretest = PretestHelper();
    dbHelperPostTest = PostTestHelper();
    isPretestExist();
  }

  isPretestExist() async{
    await dbHelperPretest.getScoreUser().then((pretestData) {

      if(pretestData != null){
        //
        setState((){
          pretestStatus = true;
        });
      } else{
        //
        setState((){
          pretestStatus = false;
        });
      }

    }).catchError((error){
      return null;
    });
  }

  isPostTestExist() async{
    await dbHelperPostTest.getScoreUser().then((postTestData) {

      if(postTestData != null){
        //
        setState((){
          postTestStatus = true;
        });
      } else{
        //
        setState((){
          postTestStatus = false;
        });
      }

    }).catchError((error){
      return null;
    });
  }

  renderMenu() {
    if(pretestStatus){
      //
      return new Center(
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                children: [
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: pretestStatus ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PretestScoreScreen()),
                          );
                        }
                        : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PretestScreen()),
                          );
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.task,
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: 100,
                        child: Text(
                          "Pre-Test",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed:() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MateriScreen()),
                          );
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.task,
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: 100,
                        child: Text(
                          "Edukasi Mater",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ]
            ),
            SizedBox(
              height: 50,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                children: [
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MateriScreen()),
                          );
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.task,
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: 100,
                        child: Text(
                          "Edukasi Oral Hygene",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: postTestStatus ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PretestScoreScreen()),
                          );
                        }
                        : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PostTestScreen()),
                          );
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.task,
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: 100,
                        child: Text(
                          "Post-Test",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ]
            ),
          ],
        ),
      );
    }else{
      return new Center(
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                children: [
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: pretestStatus ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PretestScoreScreen()),
                          );
                        }
                        : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PretestScreen()),
                          );
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.task,
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(height: 15,),
                      Text("Pre-Test"),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed:null,
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.task,
                          color: Color(0x77000000),
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: 100,
                        child: Text(
                          "Edukasi Materi",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0x77000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
            ),
            SizedBox(
              height: 50,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                children: [
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed:null,
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.task,
                          color: Color(0x77000000),
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: 100,
                        child: Text(
                          "Edukasi Oral Hygene",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0x77000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed:null,
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.task,
                          color: Color(0x77000000),
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: 100,
                        child: Text(
                          "Post-Test",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0x77000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
            ),
          ],
        ),
      );
    }
  }

  // ifPretestScoreExist() async{
  //   //
  //   await dbHelperPretest.getScoreUser().then((pretestData) {
  //
  //     if(pretestData != null){
  //       //
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const PretestScoreScreen()),
  //       );
  //     } else{
  //       //
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const PretestScreen()),
  //       );
  //     }
  //
  //   }).catchError((error){
  //     return null;
  //   });
  //
  // }
  //
  // ifPostTestScoreExist() async{
  //   //
  //   await dbHelperPostTest.getScoreUser().then((postTestData) {
  //
  //     if(postTestData != null){
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const PretestScoreScreen()),
  //       );
  //     } else{
  //       //
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const PostTestScreen()),
  //       );
  //     }
  //
  //   }).catchError((error){
  //     print(error);
  //     return null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("ini agenda"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            child: renderMenu(),
          ),
        ),
      ),
    );
  }
}

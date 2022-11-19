import 'package:flutter/material.dart';
import 'package:gigi_mia/databaseHandlers/PostTestHelper.dart';
import 'package:gigi_mia/models/PostTestModel.dart';
import 'package:gigi_mia/models/PretestModel.dart';
import 'package:gigi_mia/screens/AgendaScreen.dart';
import 'package:gigi_mia/screens/HomePage.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../databaseHandlers/PretestHelper.dart';

class PretestScoreScreen extends StatefulWidget {
  const PretestScoreScreen({Key? key}) : super(key: key);

  @override
  State<PretestScoreScreen> createState() => _PretestScoreScreenState();
}

class _PretestScoreScreenState extends State<PretestScoreScreen> {

  var dbHelperPretest;
  var dbHelperPostTest;
  double pretestScore = 0;
  double postTestScore = 0;

  @override
  void initState() {
    super.initState();
    dbHelperPretest = PretestHelper();
    dbHelperPostTest = PostTestHelper();
    getPretestScore();
    getPostTestScore();
  }

  Future<double?> getPretestScore() async{
    //
    await dbHelperPretest.getScoreUser().then((PretestModel? pretestData) {

      if(pretestData != null){
        setState((){
          pretestScore = pretestData.score!.toDouble();
        });
      } else {
        return null;
      }

    }).catchError((error){
      return null;
    });
  }
  Future<double?> getPostTestScore() async{
    //
    await dbHelperPostTest.getScoreUser().then((PostTestModel? postTestData) {

      if(postTestData != null){
        setState((){
          postTestScore = postTestData.score!.toDouble();
        });
      } else {
        return null;
      }

    }).catchError((error){
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "ini score"
          ),
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              height: MediaQuery.of(context).size.height*0.4,
              width: MediaQuery.of(context).size.width *1,
              child: BarChart(
                BarChartData(
                  groupsSpace: 10,
                  barGroups: [
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: pretestScore,
                          width: 30,
                          color: Colors.redAccent,
                        )
                      ]
                    ),
                    BarChartGroupData(
                      x: 2,
                        barRods: [
                          BarChartRodData(
                            toY: postTestScore,
                            width: 30,
                            color: Colors.green,
                          )
                        ]
                    ),
                  ],
                  baselineY: 0,
                  maxY: 100,
                  minY: 0,
                  gridData: FlGridData(
                    show: false,
                    getDrawingHorizontalLine: defaultGridLine,
                    getDrawingVerticalLine: defaultGridLine,
                  ),
                  barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.grey,
                        getTooltipItem: (_a, _b, _c, _d) => null,
                      ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      axisNameWidget: Text(
                        "percobaan test"
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: defaultGetTitle,
                      )
                    ),
                    leftTitles: AxisTitles(
                        axisNameWidget: Text(
                            "score"
                        ),
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: defaultGetTitle,
                        )
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false
                      )
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false
                      )
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                ),
                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.55),
              width: MediaQuery.of(context).size.height * 1,
              child: Column(
                children: [
                  TextButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (_)=> HomePage()), (Route<dynamic> route) => false
                        );
                      },
                      child: Text(
                          "kembali"
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

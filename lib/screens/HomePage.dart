import 'package:flutter/material.dart';
import 'package:gigi_mia/Screens/Auth/LoginScreen.dart';
import 'package:gigi_mia/screens/BiodataLansia.dart';
import 'package:gigi_mia/screens/KeluargaLansia.dart';
import 'package:gigi_mia/screens/AgendaScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // backgroundColor: Colors.red,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(190),
            child: AppBar(
              centerTitle: true,
              // backgroundColor: Colors.transparent,
              title: Text("SAHABAT LANSIA"),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              // decoration: BoxDecoration(
              //  image: DecorationImage(
              //    image: AssetImage('assets/images/background/background.jpg'),
              //   fit: BoxFit.cover,
              // ),
              //  ),
              margin: EdgeInsets.all(60.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BiodataLansia()),
                            );
                          },
                          elevation: 4.0,
                          fillColor: Colors.white,
                          child: new Image(
                            image: new AssetImage("assets/images/icon/old.png"),
                            height: 80,
                            width: 80,
                            color: null,
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("BIODATA LANSIA"),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                      Column(children: [
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const KeluargaLansia()),
                            );
                          },
                          elevation: 4.0,
                          fillColor: Colors.white,
                          child: new Image(
                            image:
                            new AssetImage("assets/images/icon/family.png"),
                            height: 80,
                            width: 80,
                            color: null,
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("KELUARGA LANSIA"),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, //Center Row contents vertically,
                    children: [
                      Column(children: [
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BiodataLansia()),
                            );
                          },
                          elevation: 4.0,
                          fillColor: Colors.white,
                          child: new Image(
                            image:
                            new AssetImage("assets/images/icon/test.png"),
                            height: 80,
                            width: 80,
                            color: null,
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("RANGKAIAN TEST"),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                      Column(children: [
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AgendaScreen()),
                            );
                          },
                          elevation: 4.0,
                          fillColor: Colors.white,
                          child: new Image(
                            image:
                            new AssetImage("assets/images/icon/agenda.png"),
                            height: 80,
                            width: 80,
                            color: null,
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("AGENDA"),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, //Center Row contents vertically,
                    children: [
                      Column(children: [
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(builder: (_)=> MyLogin()), (Route<dynamic> route) => false
                            );
                          },
                          elevation: 4.0,
                          fillColor: Colors.white,
                          child: new Image(
                            image:
                            new AssetImage("assets/images/icon/logout.png"),
                            height: 80,
                            width: 80,
                            color: null,
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("LOGOUT"),
                      ]),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

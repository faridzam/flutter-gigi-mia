import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Screens/Auth/LoginScreen.dart';

void main() async{
  runApp(const MyApp());
  requestPermission();
}

void requestPermission() async{

  var status = await Permission.storage.status;
  if(!status.isGranted){
    await Permission.storage.request();
  }

  var status1 = await Permission.manageExternalStorage.status;
  if(!status1.isGranted){
    await Permission.manageExternalStorage.request();
  }

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: Colors.blue,
      ),
      home: MyLogin(),
    );
  }
}

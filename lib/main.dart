import 'package:flutter/material.dart';

import 'Screens/Auth/LoginScreen.dart';

void main() async{
  runApp(const MyApp());
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

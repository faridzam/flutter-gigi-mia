import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:gigi_mia/screens/auth/LoginScreen.dart';
import 'package:gigi_mia/screens/HomePage.dart';
import 'dart:convert';

const SERVER_IP = '10.0.2.2:8005';
final storage = FlutterSecureStorage();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "accessToken");
    if(jwt == null) return "";
    final response = await http.post(Uri.http("10.0.2.2:8005", "/api/users/me"),
        headers: {
          'Authorization': "Bearer $jwt",
        });

    if (response.statusCode == 200) {
      return jwt;
    } else {
      storage.deleteAll();
      return "";
    }

    return jwt;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: jwtOrEmpty,
        builder: (context, snapshot){
          if(!snapshot.hasData) return CircularProgressIndicator();
          if(snapshot.data != ""){
            var str = snapshot.data;
            var jwt = str.toString().split(".");

            if(jwt.length !=3) {
              return MyLogin();
            } else {
              var payload = json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
              if(DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now())) {
                return HomePage(str.toString(), payload);
              } else {
                return MyLogin();
              }
            }
          } else {
            return MyLogin();
          }
        },
      ),
    );
  }
}

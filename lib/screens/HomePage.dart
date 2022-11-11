import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gigi_mia/screens/AgendaScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gigi_mia/screens/auth/LoginScreen.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

getUserName(jwt) async {
  final response = await http.post(Uri.http("10.0.2.2:8005", "/api/users/me"),
      headers: {
        'Authorization': "Bearer $jwt",
      });
g
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var username = "";
    jsonDecode(response.body).forEach((key, value){
      if(key == "username"){
        //
        username = value;
      }
    });
    return username;
  } else {
    storage.deleteAll();
    throw Exception('Failed to load post');
  }
}

class HomePage extends StatelessWidget {
  HomePage(this.jwt, this.payload);

  final storage = FlutterSecureStorage();

  factory HomePage.fromBase64(String jwt) =>
      HomePage(
          jwt,
          json.decode(
              ascii.decode(
                  base64.decode(base64.normalize(jwt.split(".")[1]))
              )
          )
      );

  logout(jwt) async {
    //
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken') ?? 0;
    Map<String, dynamic> requestPayload = {
      "refreshToken": refreshToken,
    };
    final response = await http.post(Uri.http("10.0.2.2:8005", "/api/auth/logout"),
      body: jsonEncode(requestPayload),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json"
      }
    );
    return null;
  }

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: [
              FutureBuilder(
                  future: getUserName(jwt),
                  builder: (context, snapshot) =>
                  snapshot.hasData ?
                  Column(children: <Widget>[
                    Text("Hi, ${snapshot.data.toString()}")
                  ],)
                      :
                  snapshot.hasError ? Text("An error occurred") : CircularProgressIndicator()
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                  child: Column(
                    children: [
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
                                    MaterialPageRoute(builder: (context) => const AgendaScreen()),
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
                              Text("Agenda"),
                            ]
                          ),
                          Column(
                            children: [
                              RawMaterialButton(
                                onPressed: () {
                                  logout(jwt);
                                  storage.deleteAll();
                                  Navigator.pushAndRemoveUntil(
                                      context, MaterialPageRoute(builder: (_)=> MyLogin()), (Route<dynamic> route) => false
                                  );

                                },
                                elevation: 2.0,
                                fillColor: Colors.white,
                                child: Icon(
                                  Icons.logout,
                                  size: 35.0,
                                ),
                                padding: EdgeInsets.all(15.0),
                                shape: CircleBorder(),
                              ),
                              SizedBox(height: 15,),
                              Text("keluar"),
                            ]
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      );
}
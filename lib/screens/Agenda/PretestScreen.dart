import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PretestScreen extends StatefulWidget {
  const PretestScreen({Key? key}) : super(key: key);

  @override
  State<PretestScreen> createState() => _PretestScreenState();
}

class _PretestScreenState extends State<PretestScreen> {

  showQuestion() async {
    //
    final response = await http.post(Uri.http("10.0.2.2:8005", "/api/test/show-question"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
    );
    if(response.body != null){
      Map<Object, dynamic> question = jsonDecode(response.body);
      return question;
    }
  }

  late List<Object> questions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("ini pretest"),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                    future: showQuestion(),
                    builder: (context, snapshot) =>
                    snapshot.hasData ?
                    Column(children: <Widget>[
                      Text(snapshot.data.toString())
                    ],)
                        :
                    snapshot.hasError ? Text("An error occurred") : CircularProgressIndicator()
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

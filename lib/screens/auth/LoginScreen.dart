import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gigi_mia/screens/HomePage.dart';
import 'package:gigi_mia/screens/auth/RegisterScreen.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  final _formKey = new GlobalKey<FormState>();

  final _conUsername = TextEditingController();
  final _conPassword = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _conUsername.dispose();
    _conPassword.dispose();
    super.dispose();
  }

  final SERVER_IP = "10.0.2.2:8005";
  final storage = FlutterSecureStorage();

  attempSignIn() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    final form = _formKey.currentState!;
    String username = _conUsername.text;
    String password = _conPassword.text;

    if (form.validate()) {
        try {
          Map<String, dynamic> requestPayload = {
            "username": username,
            "password": password,
          };

          var res = await http.post(
            Uri.http(SERVER_IP, "/api/auth/login"),
            body: jsonEncode(requestPayload),
            headers: {'Content-Type': 'application/json'},
          );

          if(res.statusCode == 200){
            final extractedData = jsonDecode(res.body) as Map;
            // set value
            await prefs.setString('userId', extractedData['id']);
            await prefs.setString('refreshToken', extractedData['refreshToken']);
            return res.body;
          };
          return null;
        } catch (error) {
          //
          Fluttertoast.showToast(
              msg: error.toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: 16.0
          );
          return null;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/auth/login.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 35, top: 80),
                  child: Text(
                    'Welcome\nBack',
                    style: TextStyle(color: Colors.white, fontSize: 33, fontWeight: FontWeight.w600),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
                          decoration: new BoxDecoration(
                            //you can get rid of below line also
                            borderRadius: new BorderRadius.circular(10.0),
                            //below line is for rectangular shape
                            shape: BoxShape.rectangle,
                            //you can change opacity with color here(I used black) for rect
                            color: Colors.white.withOpacity(0.1),
                            //I added some shadow, but you can remove boxShadow also.
                            boxShadow: <BoxShadow>[
                              new BoxShadow(
                                color: Colors.black26.withOpacity(0.2),
                                blurRadius: 5.0,
                                offset: new Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _conUsername,
                                  style: TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      filled: true,
                                      hintText: "Username",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),

                                      )
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  controller: _conPassword,
                                  style: TextStyle(color: Colors.white),
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      filled: true,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 125,
                                height: 40,
                                margin: EdgeInsets.only(left: 40, right: 40),
                                decoration: new BoxDecoration(
                                  //you can get rid of below line also
                                  borderRadius: new BorderRadius.circular(30.0),
                                  //below line is for rectangular shape
                                  shape: BoxShape.rectangle,
                                  //you can change opacity with color here(I used black) for rect
                                  color: Color(0xFFECCA92).withOpacity(0.7),
                                  //I added some shadow, but you can remove boxShadow also.
                                  boxShadow: <BoxShadow>[
                                    new BoxShadow(
                                      color: Colors.black26.withOpacity(0.2),
                                      blurRadius: 5.0,
                                      offset: new Offset(5.0, 5.0),
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () async {
                                    var jwt = await attempSignIn();
                                    if(jwt != null) {
                                      final extractedData = jsonDecode(jwt) as Map;
                                      storage.write(key: "accessToken", value: extractedData['accessToken']);
                                      Navigator.pushAndRemoveUntil(
                                          context, MaterialPageRoute(builder: (_)=> HomePage.fromBase64(extractedData['accessToken'])), (Route<dynamic> route) => false
                                      );
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => HomePage.fromBase64(extractedData['accessToken'])
                                      //     )
                                      // );
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "login failed!",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.redAccent,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  },
                                  child: Text(
                                    "sign in",
                                    style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "doesn't have an account?",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MyRegister()),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontSize: 15),
                              ),
                              style: ButtonStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
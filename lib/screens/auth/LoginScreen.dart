import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gigi_mia/screens/HomePage.dart';
import 'package:gigi_mia/screens/auth/RegisterScreen.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../databaseHandlers/DBHelper.dart';
import '../../models/UserModel.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();
  final _conUsername = TextEditingController();
  final _conPassword = TextEditingController();

  var dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }

  login() async{
    final form = _formKey.currentState!;
    String username = _conUsername.text;
    String password = _conPassword.text;

    if(username.isEmpty){
      // alertDialog("username field can't be empty");
      Fluttertoast.showToast(
          msg: "username field can't be empty!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else if(password.isEmpty){
      // alertDialog("password field can't be empty");
      Fluttertoast.showToast(
          msg: "password field can't be empty!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else{
      await dbHelper.getLoginUser(username, password).then((UserData){
        if(UserData != null){

          setSP(UserData).whenComplete((){
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_)=> HomePage()), (Route<dynamic> route) => false
            );
          });
        } else{
          // alertDialog("User not found!");
          Fluttertoast.showToast(
              msg: "user not found",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }).catchError((error){
        print(error);
        // alertDialog("login Failed");
        Fluttertoast.showToast(
            msg: "login failed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
  }

  Future setSP(UserModel user) async{
    final SharedPreferences sp = await _pref;

    sp.setInt("id", user.id);
    sp.setString("username", user.username);
    sp.setString("phone", user.phone);
    sp.setString("password", user.password);
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
                                  onPressed: login,
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
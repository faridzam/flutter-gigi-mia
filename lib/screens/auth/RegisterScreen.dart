import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gigi_mia/screens/auth/LoginScreen.dart';
import '../../databaseHandlers/DBHelper.dart';
import '../../models/UserModel.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final _formKey = new GlobalKey<FormState>();

  final _conUsername = TextEditingController();
  final _conPhone = TextEditingController();
  final _conPassword = TextEditingController();
  final _conPasswordConfirmation = TextEditingController();

  var dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }

  signUp() async{
    final form = _formKey.currentState!;
    String username = _conUsername.text;
    String phone = _conPhone.text;
    String password = _conPassword.text;
    String passwordConfirmation = _conPasswordConfirmation.text;

    if(form.validate()){
      if(password != passwordConfirmation){
        Fluttertoast.showToast(
            msg: "Password confirmation not-matched!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else{
        _formKey.currentState?.save();
        UserModel uModel = UserModel(username, phone, password);
        await dbHelper.saveData(uModel).then((userData) {
          Fluttertoast.showToast(
              msg: "User registration success!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );

          Navigator.push(
              context,
              MaterialPageRoute(builder: (_)=> MyLogin())
          );

        }).catchError((error){
          print(error);
          // alertDialog("Error: save data failed!");
          Fluttertoast.showToast(
              msg: "Error: save data failed!",
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

    // if(username.isEmpty){
    //   alertDialog(context, "Please fill username field!");
    // }else if(email.isEmpty){
    //   alertDialog(context, "Please fill email field!");
    // }else if(phone.isEmpty){
    //   alertDialog(context, "Please fill phone field!");
    // }else if(password.isEmpty){
    //   alertDialog(context, "Please fill password field!");
    // }else if(passwordConfirmation.isEmpty){
    //   alertDialog(context, "Please fill password confirmation field!");
    // }
    // print(username + email + phone + password + passwordConfirmation);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/auth/register.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 35, top: 10),
                    child: Text(
                      'Create\nAccount',
                      style: TextStyle(color: Colors.white, fontSize: 33, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.23),

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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "this field can't be empty";
                                    } else if (value.length < 8) {
                                      return "min 8 character";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Username",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _conPhone,
                                  style: TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    RegExp regex = new RegExp(r'^(?:[+0])?[0-9]{9,14}$');
                                    if (value == null || value.isEmpty) {
                                      return "this field can't be empty";
                                    } else if (!regex.hasMatch(value)){
                                      return "please enter valid phone number";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Phone",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _conPassword,
                                  style: TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "this field can't be empty";
                                    } else if (value.length < 8) {
                                      return "min 8 character";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _conPasswordConfirmation,
                                  style: TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "this field can't be empty";
                                    } else if (value.length < 8) {
                                      return "min 8 character";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Password Confirmation",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                                  onPressed: signUp,
                                  child: Text(
                                    "sign up",
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
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "already have an account?",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xff4c505b),
                                  fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MyLogin()),
                                );
                              },
                              child: Text(
                                'Sign In',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff4c505b),
                                    fontSize: 15),
                              ),
                              style: ButtonStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => const MyLogin(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return child;
//     },
//   );
// }
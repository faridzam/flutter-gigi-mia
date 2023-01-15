import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gigi_mia/Screens/Auth/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_launch/flutter_launch.dart';

import '../databaseHandlers/DBHelper.dart';
import '../models/UserModel.dart';

class AkunScreen extends StatefulWidget {
  const AkunScreen({Key? key}) : super(key: key);

  @override
  State<AkunScreen> createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {

  final _formKey = new GlobalKey<FormState>();
  final _conOldPassword = TextEditingController();
  final _conPassword = TextEditingController();
  final _conPasswordConfirmation = TextEditingController();

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  int user_id = 0;
  String username = "";
  String phone = "";
  String email = "";

  var dbHelper;

  Future<void> getUserData() async{
    final SharedPreferences sp = await _pref;

    setState((){
      user_id = sp.getInt("id")!;
      username = sp.getString("username")!;
      phone = sp.getString("phone")!;
      email = sp.getString("email")!;
    });
  }

  void openWhatsapp() async {
    await FlutterLaunch.launchWhatsapp(phone: "+6285333953171", message: "");
  }

  changePassword() async{
    final form = _formKey.currentState!;
    String oldPassword = _conOldPassword.text;
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
        await dbHelper.changePassword(user_id, oldPassword, password).then((userData) {
          Fluttertoast.showToast(
              msg: "Change Password Success",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );

          Navigator.pop(context, 'Cancel');

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
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "akun"
          ),
        ),
        body: GestureDetector(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*0.1,
                    right: 20,
                    bottom: 30,
                    left: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RawMaterialButton(
                            onPressed: null,
                            elevation: 2.0,
                            fillColor: Colors.grey,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 50.0,
                            ),
                            padding: EdgeInsets.all(5.0),
                            shape: CircleBorder(),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                phone,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Text(
                                email,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ]
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        height: 50,
                        child: TextButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Ganti Password'),
                              content: Container(
                                height: 300,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _conOldPassword,
                                      style: TextStyle(color: Colors.black87),
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
                                              color: Colors.black87,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black87,
                                            ),
                                          ),
                                          hintText: "Password",
                                          hintStyle: TextStyle(color: Colors.black87),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      controller: _conPassword,
                                      style: TextStyle(color: Colors.black87),
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
                                              color: Colors.black87,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black87,
                                            ),
                                          ),
                                          hintText: "Password",
                                          hintStyle: TextStyle(color: Colors.black87),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      controller: _conPasswordConfirmation,
                                      style: TextStyle(color: Colors.black87),
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
                                              color: Colors.black87,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black87,
                                            ),
                                          ),
                                          hintText: "Password Confirmation",
                                          hintStyle: TextStyle(color: Colors.black87),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: changePassword,
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.security,
                                size: 15,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Ganti Password",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*0.2,
                  ),
                  width: 150,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () async{
                      await FlutterLaunch.launchWhatsapp(phone: "+6285333953171", message: "");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Bantuan",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  width: 150,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (_)=> MyLogin()), (Route<dynamic> route) => false
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Keluar",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.redAccent
                          ),
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

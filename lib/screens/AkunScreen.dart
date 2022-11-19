import 'package:flutter/material.dart';
import 'package:gigi_mia/Screens/Auth/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AkunScreen extends StatefulWidget {
  const AkunScreen({Key? key}) : super(key: key);

  @override
  State<AkunScreen> createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  int user_id = 0;
  String username = "";

  Future<void> getUserData() async{
    final SharedPreferences sp = await _pref;

    setState((){
      user_id = sp.getInt("id")!;
      username = sp.getString("username")!;
    });
  }

  @override
  void initState() {
    super.initState();
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
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
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
                          Text(
                            username,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*0.3,
                  ),
                  width: 100,
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
                        Icon(Icons.logout),
                        Text("keluar"),
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

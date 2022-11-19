import 'package:flutter/material.dart';
import 'package:gigi_mia/screens/KeluargaLansia.dart';
import '../../databaseHandlers/DBHelperKeluarga.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/KeluargaModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AddKeluargaLansia extends StatefulWidget {
  const AddKeluargaLansia({Key? key}) : super(key: key);

  @override
  State<AddKeluargaLansia> createState() => _AddKeluargaLansia();
}

class _AddKeluargaLansia extends State<AddKeluargaLansia> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  int user_id = 0;
  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;
    setState(() {
      user_id = sp.getInt("id")!;
    });
  }

  final _formKey = new GlobalKey<FormState>();
  final _conNama = TextEditingController();
  final _conUsia = TextEditingController();
  final _conTanggalLahir = TextEditingController();
  final _conTingkatPendidikan = TextEditingController();

  var dbHelper;

  @override
  void initState() {
    super.initState();
    getUserData();
    dbHelper = DBHelperKeluarga();
  }

  addkeluarga() async {
    final form = _formKey.currentState!;

    String nama = _conNama.text;
    String usia = _conUsia.text;
    String tanggallahir = _conTanggalLahir.text;
    String tingkatpendidikan = _conTingkatPendidikan.text;

    if (form.validate()) {
      if (nama == 'null') {
        Fluttertoast.showToast(
            msg: "error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        _formKey.currentState?.save();
        KeluargaModel uModel =
            KeluargaModel(user_id, nama, usia, tanggallahir, tingkatpendidikan);
        await dbHelper.saveDataKeluarga(uModel).then((keluargaData) {
          Fluttertoast.showToast(
              msg: "Tambah Keluarga success!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          Navigator.of(context).pop();
        }).catchError((error) {
          print(error);
          Fluttertoast.showToast(
              msg: "Error: save data failed!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
            backgroundColor: Colors.greenAccent,
            appBar: AppBar(
              backgroundColor: Colors.lightBlue,
              centerTitle: true,
              title: Text("TAMBAH KELUARGA LANSIA"),
              elevation: 0,
            ),
            body: SingleChildScrollView(
                child: Container(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          decoration: new BoxDecoration(
                            //you can get rid of below line also
                            borderRadius: new BorderRadius.circular(10.0),
                            //below line is for rectangular shape
                            shape: BoxShape.rectangle,
                            //you can change opacity with color here(I used black) for rect
                            color: Colors.white.withOpacity(0.07),
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
                                  controller: _conNama,
                                  style: TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Masukkan Nama Keluarga";
                                    } else if (value.length < 2) {
                                      return "error";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      icon: ImageIcon(
                                        AssetImage(
                                            "assets/images/icon/name.png"),
                                      ),
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
                                      hintText: "Nama Lengkap",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _conUsia,
                                  style: TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Masukkan Usia ";
                                    } else if (value.length < 1) {
                                      return "error";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      icon: ImageIcon(
                                        AssetImage(
                                            "assets/images/icon/age.png"),
                                      ),
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
                                      hintText: "Usia ",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                    controller: _conTanggalLahir,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.calendar_today),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        hintText: "Tanggal lahir ",
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                    readOnly:
                                        true, // when true user cannot edit text
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime
                                                  .now(), //get today's date
                                              firstDate: DateTime(
                                                  1850), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101));
                                      //when click we have to show the datepicker
                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy').format(
                                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2022-07-04
                                        //You can format date as per your need

                                        setState(() {
                                          _conTanggalLahir.text =
                                              formattedDate; //set foratted date to TextField value.
                                        });
                                      } else {
                                        print("Date is not selected");
                                      }
                                    }),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _conTingkatPendidikan,
                                  style: TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Masukkan Tingkat Pendidikan ";
                                    } else if (value.length < 1) {
                                      return "error";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.school),
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
                                      hintText: "Tingkat pendidikan",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 125,
                                        height: 40,
                                        margin: EdgeInsets.only(
                                            left: 40, right: 40),
                                        decoration: new BoxDecoration(
                                          //you can get rid of below line also
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                          //below line is for rectangular shape
                                          shape: BoxShape.rectangle,
                                          //you can change opacity with color here(I used black) for rect
                                          color: Color(0xFFECCA92)
                                              .withOpacity(0.7),
                                          //I added some shadow, but you can remove boxShadow also.
                                          boxShadow: <BoxShadow>[
                                            new BoxShadow(
                                              color: Colors.black26
                                                  .withOpacity(0.2),
                                              blurRadius: 5.0,
                                              offset: new Offset(5.0, 5.0),
                                            ),
                                          ],
                                        ),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: addkeluarga,
                                          child: Text(
                                            "Tambah",
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))));
  }
}

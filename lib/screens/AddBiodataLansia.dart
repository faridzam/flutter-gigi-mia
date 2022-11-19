import 'package:flutter/material.dart';
import 'package:gigi_mia/screens/BiodataLansia.dart';
import '../../databaseHandlers/DBHelperLansia.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/LansiaModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<String> list = <String>[
  'LAKI-LAKI',
  'PEREMPUAN',
];

class AddBiodataLansia extends StatefulWidget {
  const AddBiodataLansia({Key? key}) : super(key: key);

  @override
  State<AddBiodataLansia> createState() => _AddBiodataLansia();
}

class _AddBiodataLansia extends State<AddBiodataLansia> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  int user_id = 0;
  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;
    setState(() {
      user_id = sp.getInt("id")!;
    });
  }

  String dropdownValue = list.first;
  String? selectedValue = null;

  final _formKey = new GlobalKey<FormState>();
  final _conNama = TextEditingController();
  final _conUsia = TextEditingController();
  String _conJenisKelamin = "";

  var dbHelper;

  @override
  void initState() {
    super.initState();
    getUserData();
    dbHelper = DBHelperLansia();
  }

  addBio() async {
    final form = _formKey.currentState!;
    String nama = _conNama.text;
    String usia = _conUsia.text;
    String jeniskelamin = _conJenisKelamin;

    if (form.validate()) {
      if (nama == "null") {
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
        LansiaModel uModel = LansiaModel(user_id, nama, usia, jeniskelamin);
        await dbHelper.saveDataLansia(uModel).then((lansiaData) {
          Fluttertoast.showToast(
              msg: "Tambah lansia success!",
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: Text("TAMBAH BIODATA LANSIA"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.23),
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
                                controller: _conNama,
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Masukkan Nama Lansia";
                                  } else if (value.length < 1) {
                                    return "error";
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
                                    return "Masukkan Usia Lansia";
                                  } else if (value.length < 1) {
                                    return "error";
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
                                    hintText: "Usia Lansia",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              DropdownButtonFormField(

                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Jenis Kelamin",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.blueAccent,
                                ),
                                validator: (value) => value == null
                                    ? "Pilih Jenis Kelamin"
                                    : null,
                                dropdownColor: Colors.blueAccent,
                                value: selectedValue,
                                style: const TextStyle(color: Colors.white),
                                onChanged: (String? value) {
                                  // Fluttertoast.showToast(
                                  //   msg: value.toString(),
                                  // toastLength: Toast.LENGTH_LONG,
                                  //gravity: ToastGravity.BOTTOM,
                                  //timeInSecForIosWeb: 1,
                                  //backgroundColor: Colors.green,
                                  //textColor: Colors.white,
                                  //fontSize: 16.0);
                                  // This is called when the user selects an item.
                                  setState(() {
                                    _conJenisKelamin= value!;
                                  });
                                },
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
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
                                onPressed: addBio,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

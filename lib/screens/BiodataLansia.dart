import 'package:flutter/material.dart';
import 'package:gigi_mia/databaseHandlers/DBHelperLansia.dart';
import 'package:gigi_mia/screens/AddBiodataLansia.dart';
import '../../models/LansiaModel.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BiodataLansia extends StatefulWidget {
  const BiodataLansia({Key? key}) : super(key: key);

  @override
  State<BiodataLansia> createState() => _BiodataLansia();
}

class _BiodataLansia extends State<BiodataLansia> {
  Future delete(int id) async {
    await dbHelper.delete(id);
    setState(() {});
  }

  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelperLansia();
  }

  @override
  Widget build(BuildContext context) {
    //return MaterialApp(
    // debugShowCheckedModeBanner: false,
    //home: Scaffold(
    // Hilangkan tombol back
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("BIODATA LANSIA"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddBiodataLansia()),
                ).then((_) => setState(() {}));
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: dbHelper.showLansia(),
          builder: (BuildContext context,
              AsyncSnapshot<List<LansiaModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, //Center Row contents vertically,
                        children: <Widget>[
                          Container(
                            width: 390,
                            height: 200,
                            padding: new EdgeInsets.all(10.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Color.fromARGB(255, 245, 171, 53),
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 6.0,
                                                bottom: 3.0,
                                                right: 6.0,
                                                top: 6.0),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 6.0,
                                                    bottom: 3.0,
                                                    right: 6.0,
                                                    top: 6.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    text:
                                                        'Nama                = ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: snapshot
                                                              .data![index]
                                                              .nama,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ],
                                                  ),
                                                )))
                                      ],
                                    ),
                                  ]),
                                  Column(children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 6.0,
                                                bottom: 3.0,
                                                right: 6.0,
                                                top: 3.0),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 6.0,
                                                    bottom: 3.0,
                                                    right: 6.0,
                                                    top: 3.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: 'Jenis Kelamin  = ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: snapshot
                                                              .data![index]
                                                              .jeniskelamin,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ],
                                                  ),
                                                )))
                                      ],
                                    ),
                                  ]),
                                  Column(children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 6.0,
                                                bottom: 3.0,
                                                right: 6.0,
                                                top: 3.0),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 6.0,
                                                    bottom: 1.0,
                                                    right: 6.0,
                                                    top: 3.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    text:
                                                        'Usia                   = ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: snapshot
                                                              .data![index]
                                                              .usia,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ],
                                                  ),
                                                )))
                                      ],
                                    ),
                                  ]),
                                  ListTile(
                                    trailing: FloatingActionButton(
                                      onPressed: () async {
                                        if (await confirm(
                                          context,
                                          title: const Text('Confirm'),
                                          content:
                                              const Text('Hapus data ini?'),
                                          textOK: const Text('Yes'),
                                          textCancel: const Text('No'),
                                        )) {
                                          Fluttertoast.showToast(
                                              msg: "Data berhasil di hapus",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          return delete(
                                              snapshot.data![index].id);
                                        }
                                        return print('pressedCancel');
                                      },
                                      backgroundColor: Colors.redAccent,
                                      child: const Icon(Icons.delete),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ])
                  ]);
                },
              );
            } else {
              return Text(
                "",
              );
            }
          },
        ),
      ),
    );
  }
}

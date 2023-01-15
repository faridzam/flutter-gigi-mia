import 'package:flutter/material.dart';
import 'package:gigi_mia/databaseHandlers/DBHelperKeluarga.dart';
import 'package:gigi_mia/models/KeluargaModel.dart';
import 'package:gigi_mia/screens/AddKeluargaLansia.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KeluargaLansia extends StatefulWidget {
  const KeluargaLansia({Key? key}) : super(key: key);

  @override
  State<KeluargaLansia> createState() => _KeluargaLansia();
}

class _KeluargaLansia extends State<KeluargaLansia> {
  Future delete(int id) async {
    await dbHelper.delete(id);
    setState(() {});
  }

  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelperKeluarga();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("KELUARGA LANSIA"),
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
                      builder: (context) => const AddKeluargaLansia()),
                ).then((_) => setState(() {}));
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: dbHelper.showKeluarga(),
          builder: (BuildContext context,
              AsyncSnapshot<List<KeluargaModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, //Center Row contents vertically,
                        children: <Widget>[
                          Container(
                            width: 390,
                            height: 225,
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
                                                    text: 'Tanggal Lahir   = ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: snapshot
                                                              .data![index]
                                                              .tanggallahir,
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
                                                    text: 'Pendidikan      = ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: snapshot
                                                              .data![index]
                                                              .tingkatpendididkan,
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
                          ),
                        ],
                      ),
                    ],
                  );
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

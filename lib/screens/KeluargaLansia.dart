import 'package:flutter/material.dart';
import 'package:gigi_mia/databaseHandlers/DBHelperKeluarga.dart';
import 'package:gigi_mia/models/KeluargaModel.dart';
import 'package:gigi_mia/screens/AddKeluargaLansia.dart';

class KeluargaLansia extends StatefulWidget {
  const KeluargaLansia({Key? key}) : super(key: key);

  @override
  State<KeluargaLansia> createState() => _KeluargaLansia();
}

class _KeluargaLansia extends State<KeluargaLansia> {
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddKeluargaLansia()),
            ).then((_) => setState(() {}));
            // Add your onPressed code here!
          },
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(Icons.add),
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
                            width: 360,
                            height: 100,
                            padding: new EdgeInsets.all(10.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.lightBlueAccent,
                              elevation: 10,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    snapshot.data![index].nama,
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    snapshot.data![index].usia,
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    snapshot.data![index].tanggallahir,
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    snapshot.data![index].tingkatpendididkan,
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.left,
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
              return Center(
                child: Scaffold(
                    floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddKeluargaLansia()),
                    );
                    // Add your onPressed code here!
                  },
                  backgroundColor: Colors.lightBlueAccent,
                  child: const Icon(Icons.add),
                )),
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gigi_mia/databaseHandlers/DBHelperLansia.dart';
import 'package:gigi_mia/screens/AddBiodataLansia.dart';
import '../../models/LansiaModel.dart';

class BiodataLansia extends StatefulWidget {
  const BiodataLansia({Key? key}) : super(key: key);

  @override
  State<BiodataLansia> createState() => _BiodataLansia();
}

class _BiodataLansia extends State<BiodataLansia> {
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddBiodataLansia()),
            ).then((_) => setState(() {}));
            // Add your onPressed code here!
          },
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: dbHelper.showLansia(),
          builder: (BuildContext context,
              AsyncSnapshot<List<LansiaModel>> snapshot) {
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
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    snapshot.data![index].nama,
                                  ),
                                  Text(
                                    snapshot.data![index].usia,
                                  ),
                                  Text(
                                    snapshot.data![index].jeniskelamin,
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
                          builder: (context) => const AddBiodataLansia()),
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

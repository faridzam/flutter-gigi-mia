import 'package:flutter/material.dart';
import 'package:gigi_mia/screens/Agenda/AyoScreen.dart';
import 'package:gigi_mia/screens/Agenda/KesehatanScreen.dart';
import 'package:gigi_mia/screens/Agenda/GosokgigiScreen.dart';
import 'package:gigi_mia/screens/Agenda/BagiangigiScreen.dart';
import 'package:gigi_mia/screens/Agenda/MenjagaScreen.dart';

class PerencanaanScreen extends StatefulWidget {
  const PerencanaanScreen({Key? key}) : super(key: key);

  @override
  State<PerencanaanScreen> createState() => _PerencanaanScreen();
}

class _PerencanaanScreen extends State<PerencanaanScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("PERENCANAAN"),
            ),
            body: ListView(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Card(
                child: ListTile(
                  tileColor: Color.fromARGB(255, 245, 171, 53),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/perencanaan/ayo.jpg"),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AyoScreen()),
                    ).then((_) => setState(() {}));
                  },
                  title: Text('Ayo rutin periksa gigi'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: ListTile(
                  tileColor: Color.fromARGB(255, 245, 171, 53),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/perencanaan/kesehatan.jpg"),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const KesehatanScreen()),
                    ).then((_) => setState(() {}));
                  },
                  title: Text('Makanan Yang Menyehatkan dan Merusak Gigi '),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: ListTile(
                  tileColor: Color.fromARGB(255, 245, 171, 53),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/perencanaan/gosokgigi.jpg"),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GosokgigiScreen()),
                    ).then((_) => setState(() {}));
                  },
                  title: Text('Cara Menggosok Gigi'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: ListTile(
                  tileColor: Color.fromARGB(255, 245, 171, 53),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/perencanaan/masalah.jpeg"),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BagiangigiScreen()),
                    ).then((_) => setState(() {}));
                  },
                  title: Text('Penyakit Gigi dan Mulut Lansia '),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: ListTile(
                  tileColor: Color.fromARGB(255, 245, 171, 53),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/perencanaan/kesehatan.jpeg"),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MenjagaScreen()),
                    ).then((_) => setState(() {}));
                  },
                  title: Text('Menjaga Kebersihan Gigi dan Mulut Lansia '),
                ),
              )
            ])));
  }
}

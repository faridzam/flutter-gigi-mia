import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:gigi_mia/screens/BiodataLansia.dart';

class AyoScreen extends StatefulWidget {
  const AyoScreen({Key? key}) : super(key: key);

  @override
  State<AyoScreen> createState() => _AyoScreen();
}

class _AyoScreen extends State<AyoScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("PERENCANAAN"),
            ),
            body: Container(
                child: PhotoView(
              backgroundDecoration: BoxDecoration(color: Colors.white),
              imageProvider: AssetImage("assets/images/perencanaan/ayo.jpg"),
            ))));
  }
}

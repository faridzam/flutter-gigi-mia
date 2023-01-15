import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MenjagaScreen extends StatefulWidget {
  const MenjagaScreen({Key? key}) : super(key: key);

  @override
  State<MenjagaScreen> createState() => _MenjagaScreen();
}

class _MenjagaScreen extends State<MenjagaScreen> {
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
              backgroundDecoration: BoxDecoration(color: Colors.transparent),
              imageProvider:
                  AssetImage("assets/images/perencanaan/kesehatan.jpeg"),
            ))));
  }
}

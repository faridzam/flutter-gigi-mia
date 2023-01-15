import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class KesehatanScreen extends StatefulWidget {
  const KesehatanScreen({Key? key}) : super(key: key);

  @override
  State<KesehatanScreen> createState() => _KesehatanScreen();
}

class _KesehatanScreen extends State<KesehatanScreen> {
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
                  AssetImage("assets/images/perencanaan/kesehatan.jpg"),
            ))));
  }
}

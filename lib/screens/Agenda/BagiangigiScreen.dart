import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class BagiangigiScreen extends StatefulWidget {
  const BagiangigiScreen({Key? key}) : super(key: key);

  @override
  State<BagiangigiScreen> createState() => _BagiangigiScreen();
}

class _BagiangigiScreen extends State<BagiangigiScreen> {
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
                  AssetImage("assets/images/perencanaan/masalah.jpeg"),
            ))));
  }
}

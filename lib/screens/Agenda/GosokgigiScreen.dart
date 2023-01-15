import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class GosokgigiScreen extends StatefulWidget {
  const GosokgigiScreen({Key? key}) : super(key: key);

  @override
  State<GosokgigiScreen> createState() => _GosokgigiScreen();
}

class _GosokgigiScreen extends State<GosokgigiScreen> {
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
                  AssetImage("assets/images/perencanaan/gosokgigi.jpg"),
            ))));
  }
}

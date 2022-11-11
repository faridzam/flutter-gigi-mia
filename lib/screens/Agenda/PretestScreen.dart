import 'package:flutter/material.dart';

class PretestScreen extends StatefulWidget {
  const PretestScreen({Key? key}) : super(key: key);

  @override
  State<PretestScreen> createState() => _PretestScreenState();
}

class _PretestScreenState extends State<PretestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("ini pretest"),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              //
            ),
          ),
        ),
      ),
    );
  }
}

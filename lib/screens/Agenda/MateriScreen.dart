import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../../components/DisplayPdf.dart';

import 'package:permission_handler/permission_handler.dart';

class MateriScreen extends StatefulWidget {
  const MateriScreen({Key? key}) : super(key: key);

  @override
  State<MateriScreen> createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {

  String Materi1PDF = "";
  String Materi2PDF = "";
  String Materi3PDF = "";
  String Materi4PDF = "";
  String Materi5PDF = "";
  final String Materi1PDFPath = "assets/pdf/MODUL_ASUHAN.pdf";
  final String Materi2PDFPath = "assets/pdf/MODUL_CARA_MENYIKAT_GIGI.pdf";
  final String Materi3PDFPath = "assets/pdf/MODUL_KARIES_DAN_KARANG_GIGI.pdf";
  final String Materi4PDFPath = "assets/pdf/MODUL_KEBERSIHAN_GIGI_DAN_MULUT.pdf";
  final String Materi5PDFPath = "assets/pdf/MODUL_PERTUMBUHAN_GIGI.pdf";

  @override
  void initState() {
    super.initState();
    fromAsset(Materi1PDFPath, 'MODUL_ASUHAN.pdf').then((f) {
      setState(() {
        Materi1PDF = f.path;
      });
    });
    fromAsset(Materi2PDFPath, 'MODUL_CARA_MENYIKAT_GIGI.pdf').then((f) {
      setState(() {
        Materi2PDF = f.path;
      });
    });
    fromAsset(Materi3PDFPath, 'MODUL_KARIES_DAN_KARANG_GIGI.pdf').then((f) {
      setState(() {
        Materi3PDF = f.path;
      });
    });
    fromAsset(Materi4PDFPath, 'MODUL_KEBERSIHAN_GIGI_DAN_MULUT.pdf').then((f) {
      setState(() {
        Materi4PDF = f.path;
      });
    });
    fromAsset(Materi5PDFPath, 'MODUL_PERTUMBUHAN_GIGI.pdf').then((f) {
      setState(() {
        Materi5PDF = f.path;
      });
    });

  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final url = "http://www.pdf995.com/samples/pdf.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();
    try {
      var dir = Directory('/storage/emulated/0/Documents');
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "ini materi"
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text(
                  "Modul",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(
                        Radius.circular(30)
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 270,
                          child: TextButton(
                            onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> DisplayPdf(path: Materi1PDF, asset: Materi1PDFPath))),
                            child: Text(
                              "Modul Asuhan",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              alignment: Alignment.centerLeft,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          // child: TextButton(
                          //   onPressed: () {
                          //     print("action");
                          //   },
                          //   child: Icon(Icons.more_vert),
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                          //     alignment: Alignment.centerLeft,
                          //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                          //   ),
                          // ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(
                        Radius.circular(30)
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 270,
                          child: TextButton(
                            onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> DisplayPdf(path: Materi2PDF, asset: Materi2PDFPath))),
                            child: Text(
                              "Modul Cara Menyikat Gigi",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              alignment: Alignment.centerLeft,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          // child: TextButton(
                          //   onPressed: () {
                          //     print("action");
                          //   },
                          //   child: Icon(Icons.more_vert),
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                          //     alignment: Alignment.centerLeft,
                          //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                          //   ),
                          // ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(
                        Radius.circular(30)
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 270,
                          child: TextButton(
                            onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> DisplayPdf(path: Materi3PDF, asset: Materi3PDFPath))),
                            child: Text(
                              "Modul Karies dan Karang Gigi",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              alignment: Alignment.centerLeft,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          // child: TextButton(
                          //   onPressed: () {
                          //     print("action");
                          //   },
                          //   child: Icon(Icons.more_vert),
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                          //     alignment: Alignment.centerLeft,
                          //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                          //   ),
                          // ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(
                        Radius.circular(30)
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 270,
                          child: TextButton(
                            onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> DisplayPdf(path: Materi4PDF, asset: Materi4PDFPath))),
                            child: Text(
                              "Modul Kebersihan Gigi dan Mulut",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              alignment: Alignment.centerLeft,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          // child: TextButton(
                          //   onPressed: () {
                          //     print("action");
                          //   },
                          //   child: Icon(Icons.more_vert),
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                          //     alignment: Alignment.centerLeft,
                          //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                          //   ),
                          // ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(
                        Radius.circular(30)
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 270,
                          child: TextButton(
                            onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> DisplayPdf(path: Materi5PDF, asset: Materi5PDFPath))),
                            child: Text(
                              "Modul Pertumbuhan Gigi",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              alignment: Alignment.centerLeft,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          // child: TextButton(
                          //   onPressed: () {
                          //     print("action");
                          //   },
                          //   child: Icon(Icons.more_vert),
                          //   style: TextButton.styleFrom(
                          //     padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                          //     alignment: Alignment.centerLeft,
                          //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                          //   ),
                          // ),
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

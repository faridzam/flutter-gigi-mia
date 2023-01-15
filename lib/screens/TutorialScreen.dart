import 'package:flutter/material.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreen();
}

class _TutorialScreen extends State<TutorialScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text("Tutorial"),
            ),
            body: SingleChildScrollView(
//scrollable Text - > wrap in SingleChildScrollView -> wrap that in Expanded
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Column(children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'A. Perizinan Aplikasi',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                          ),
                        ]),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '1. Beri izin untuk mengakses penyimpanan, pilih ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '"Izinkan" ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      // TextSpan(
                                      //text: 'B. Registrasi Akun & Login',
                                      //style: TextStyle(
                                      //   color: Colors.black, fontSize: 25),
                                      //  ),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'B. Registrasi Akun & Login',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: '1. Lakukan registrasi dengan klik, ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '"Signup"',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '2. Isi form registrasi dengan benar,kemudian klik ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '"Submit"',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '3. Isi form login dengan akun yang baru saja anda registrasi, \n    kemudian klik ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '"Sign In"',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'C. Input Biodata Lansia',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '1. Klik menu biodata lansia , kemudian klik tombol ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '" + "',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '2. Isi form biodata lansia dengan benar,kemudian klik ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '"Tambah"',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'D. Input Biodata Keluarga',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '1. Klik menu keluarga lansia , kemudian klik tombol ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '" + "',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '2. Isi form biodata keluarga dengan benar,kemudian klik ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '"Tambah"',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'E. Pre Test ',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: '1. klik menu ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '" agenda "',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      TextSpan(
                                        text: ' lalu pilih menu ',
                                      ),
                                      TextSpan(
                                          text: '"Pre Test"',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '2. Jawab semua pertanyaan, kemudian klik  ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '"Submit"',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '3. Skor anda akan muncul , dan anda dapat mengakses \n    menu selanjutnya ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                  ),
                                )))
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'F. Materi dan Poster ',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '1. Anda dapat mengakses materi pdf dengan klik menu ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '" agenda " \n',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      TextSpan(
                                        text: '    lalu pilih menu ',
                                      ),
                                      TextSpan(
                                          text: '"Edukasi Master"',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '2. Untuk materi poster anda dapat mengakses dengan klik menu \n ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '   "agenda" ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      TextSpan(
                                        text: ' lalu pilih menu ',
                                      ),
                                      TextSpan(
                                          text: '"Perencanaan"',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  ]),
                  Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 28.0,
                                    bottom: 3.0,
                                    right: 3.0,
                                    top: 3.0),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '3. Setelah membaca semua materi, maka anda dapat \n    melanjutkan ketahap Post Test ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                  ),
                                )))
                      ],
                    ),
                  ]),
                ]))));
  }
}

class PemeriksaanModel {
  late int id;
  int? user_id;
  String nama = '';
  String umur = '';
  String jenis_kelamin = '';
  String kelainan_gigi = '';

  PemeriksaanModel(this.user_id, this.nama, this.umur, this.jenis_kelamin, this.kelainan_gigi);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'nama': nama,
      'umur': umur,
      'jenis_kelamin': jenis_kelamin,
      'kelainan_gigi': kelainan_gigi,
    };
    return map;
  }

  PemeriksaanModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    user_id = map['user_id'];
    nama = map['nama'];
    umur = map['umur'];
    jenis_kelamin = map['jenis_kelamin'];
    kelainan_gigi = map['kelainan_gigi'];
  }
}

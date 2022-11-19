class LansiaModel {
  late int id;
  int? user_id;
  String nama = '';
  String usia = '';
  String jeniskelamin = '';

  LansiaModel(this.user_id, this.nama, this.usia, this.jeniskelamin);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'nama': nama,
      'usia': usia,
      'jeniskelamin': jeniskelamin,
    };
    return map;
  }

  LansiaModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    user_id = map['user_id'];
    nama = map['nama'];
    usia = map['usia'];
    jeniskelamin = map['jeniskelamin'];
  }
}

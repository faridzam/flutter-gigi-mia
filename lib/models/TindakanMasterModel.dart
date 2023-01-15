class TindakanMasterModel{
  late int id;
  late int type;
  late String text;

  TindakanMasterModel(this.type, this.text);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'type': type,
      'text': text,
    };
    return map;
  }

  TindakanMasterModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    type = map['type'];
    text = map['text'];
  }

}
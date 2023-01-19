class TindakanUserModel{
  late int id;
  late int user_id;
  late int tindakan_id;
  late int type;
  late int answer;

  TindakanUserModel(this.user_id, this.tindakan_id, this.type, this.answer);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'tindakan_id': tindakan_id,
      'type': type,
      'answer': answer,
    };
    return map;
  }

  TindakanUserModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    user_id = map['user_id'];
    tindakan_id = map['tindakan_id'];
    type = map['type'];
    answer = map['answer'];
  }

}
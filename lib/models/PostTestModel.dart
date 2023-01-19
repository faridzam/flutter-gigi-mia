class PostTestModel{
  late int id;
  int? user_id;
  int? type;
  int? score;

  PostTestModel(this.user_id, this.type,this.score);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'type': type,
      'score': score,
    };
    return map;
  }

  PostTestModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    user_id = map['user_id'];
    type = map['type'];
    score = map['score'];
  }

}
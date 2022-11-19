class PretestModel{
  late int id;
  int? user_id;
  int? score;

  PretestModel(this.user_id, this.score);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'score': score,
    };
    return map;
  }

  PretestModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    user_id = map['user_id'];
    score = map['score'];
  }

}
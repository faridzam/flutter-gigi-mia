class QuestionModel{
  late int id;
  late String question_text;

  QuestionModel(this.question_text);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'question_text': question_text,
    };
    return map;
  }

  QuestionModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    question_text = map['question_text'];
  }

}
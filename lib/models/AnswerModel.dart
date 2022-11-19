class AnswerModel{
  late int id;
  int? question_id;
  String? answer_text;
  int? isTrue;

  AnswerModel(this.question_id, this.answer_text, this.isTrue);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'question_id': question_id,
      'answer_text': answer_text,
      'isTrue' : isTrue,
    };
    return map;
  }

  AnswerModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    question_id = map['question_id'];
    answer_text = map['answer_text'];
    isTrue = map['isTrue'];
  }

}
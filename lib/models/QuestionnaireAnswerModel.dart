class QuestionnaireAnswerModel{
  int? value;
  String? answer_text;

  QuestionnaireAnswerModel(this.value, this.answer_text);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'value': value,
      'answer_text': answer_text,
    };
    return map;
  }

  QuestionnaireAnswerModel.fromMap(Map<String, dynamic> map){
    value = map['value'];
    answer_text = map['answer_text'];
  }

}
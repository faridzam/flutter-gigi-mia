class QuestionModel{
  late String question_text;

  QuestionModel({
    required this.question_text,
  });

  //Gettters
  String get _name => question_text;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'question_text': question_text,
    };
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.question_text;
    return data;
  }

  QuestionModel.fromMap(Map<String, dynamic> map){
    question_text = map['question_text'];
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        question_text: json["question_text"],
    );
  }
}
class QuizModel {
  final String word;
  final String mean;
  final int quizSpace;
  final String email;

  const QuizModel({ 
    required this.word,
    required this.mean,
    required this.quizSpace,
    required this.email,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      word: json['word'],
      mean: json['mean'],
      quizSpace: json['quizSpace'],
      email: json['uid'],
    );
  }
}
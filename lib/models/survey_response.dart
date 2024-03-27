class SurveyResponse {
  final String id;
  final String userId;
  final String surveyId;
  final List<Map<String, dynamic>> answers;

  SurveyResponse({
    required this.id,
    required this.userId,
    required this.surveyId,
    required this.answers,
  });

  factory SurveyResponse.fromJson(Map<String, dynamic> json) {
    return SurveyResponse(
      id: json['id'],
      userId: json['userId'],
      surveyId: json['surveyId'],
      answers: List<Map<String, dynamic>>.from(json['answers']),
    );
  }
}

class Survey {
  final String id;
  final String title;
  final String description;

  Survey({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}

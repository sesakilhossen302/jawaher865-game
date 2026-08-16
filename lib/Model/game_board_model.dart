class QuestionPointModel {
  final String id;
  final int points; // 200, 400, 600
  final String side; // 'left' or 'right'
  final String questionText;
  final String answerText;
  final bool isUsed;

  QuestionPointModel({
    required this.id,
    required this.points,
    required this.side,
    this.questionText = '',
    this.answerText = '',
    this.isUsed = false,
  });

  factory QuestionPointModel.fromJson(Map<String, dynamic> json) {
    return QuestionPointModel(
      id: json['id']?.toString() ?? '',
      points: json['points'] is int
          ? json['points']
          : int.tryParse(json['points']?.toString() ?? '200') ?? 200,
      side: json['side'] ?? 'left',
      questionText: json['question_text'] ?? '',
      answerText: json['answer_text'] ?? '',
      isUsed: json['is_used'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'points': points,
      'side': side,
      'question_text': questionText,
      'answer_text': answerText,
      'is_used': isUsed,
    };
  }

  QuestionPointModel copyWith({
    String? id,
    int? points,
    String? side,
    String? questionText,
    String? answerText,
    bool? isUsed,
  }) {
    return QuestionPointModel(
      id: id ?? this.id,
      points: points ?? this.points,
      side: side ?? this.side,
      questionText: questionText ?? this.questionText,
      answerText: answerText ?? this.answerText,
      isUsed: isUsed ?? this.isUsed,
    );
  }
}

class GameBoardBlockModel {
  final int id;
  final String title;
  final String imagePath;
  final String? iconUrl;
  final List<int> pointValues;

  GameBoardBlockModel({
    required this.id,
    required this.title,
    required this.imagePath,
    this.iconUrl,
    this.pointValues = const [200, 400, 600],
  });

  factory GameBoardBlockModel.fromJson(Map<String, dynamic> json) {
    return GameBoardBlockModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title'] ?? json['name'] ?? '',
      imagePath: json['image_path'] ?? json['image'] ?? '',
      iconUrl: json['icon_url'],
      pointValues: json['point_values'] != null
          ? List<int>.from(json['point_values'])
          : const [200, 400, 600],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_path': imagePath,
      'icon_url': iconUrl,
      'point_values': pointValues,
    };
  }
}

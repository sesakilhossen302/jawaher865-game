class TeamModel {
  final String id;
  final String name;
  final String teamType; // 'blue' or 'red'
  final int score;
  final String avatarInitials;
  final bool isTurn;

  TeamModel({
    required this.id,
    required this.name,
    required this.teamType,
    this.score = 1000,
    this.avatarInitials = 'T',
    this.isTurn = false,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? json['team_name'] ?? '',
      teamType: json['team_type'] ?? 'blue',
      score: json['score'] is int
          ? json['score']
          : int.tryParse(json['score']?.toString() ?? '1000') ?? 1000,
      avatarInitials: json['avatar_initials'] ?? 'T',
      isTurn: json['is_turn'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'team_type': teamType,
      'score': score,
      'avatar_initials': avatarInitials,
      'is_turn': isTurn,
    };
  }

  TeamModel copyWith({
    String? id,
    String? name,
    String? teamType,
    int? score,
    String? avatarInitials,
    bool? isTurn,
  }) {
    return TeamModel(
      id: id ?? this.id,
      name: name ?? this.name,
      teamType: teamType ?? this.teamType,
      score: score ?? this.score,
      avatarInitials: avatarInitials ?? this.avatarInitials,
      isTurn: isTurn ?? this.isTurn,
    );
  }
}

class OnlinePlayerModel {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isYourTeam;
  final int score;

  OnlinePlayerModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isYourTeam = false,
    this.score = 0,
  });

  factory OnlinePlayerModel.fromJson(Map<String, dynamic> json) {
    return OnlinePlayerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      isYourTeam: json['is_your_team'] ?? false,
      score: json['score'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar_url': avatarUrl,
      'is_your_team': isYourTeam,
      'score': score,
    };
  }
}

class OnlineGameMatchModel {
  final String matchId;
  final List<OnlinePlayerModel> team1;
  final List<OnlinePlayerModel> team2;
  final String status;

  OnlineGameMatchModel({
    required this.matchId,
    required this.team1,
    required this.team2,
    this.status = 'ready',
  });

  factory OnlineGameMatchModel.fromJson(Map<String, dynamic> json) {
    return OnlineGameMatchModel(
      matchId: json['match_id'] ?? '',
      team1: (json['team1'] as List<dynamic>?)
              ?.map((e) => OnlinePlayerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      team2: (json['team2'] as List<dynamic>?)
              ?.map((e) => OnlinePlayerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] ?? 'ready',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'match_id': matchId,
      'team1': team1.map((e) => e.toJson()).toList(),
      'team2': team2.map((e) => e.toJson()).toList(),
      'status': status,
    };
  }
}

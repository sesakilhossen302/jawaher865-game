class LeaderboardUserModel {
  final int rank;
  final String name;
  final String username;
  final String avatarUrl;
  final int points;

  LeaderboardUserModel({
    required this.rank,
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.points,
  });

  factory LeaderboardUserModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardUserModel(
      rank: json['rank'] ?? 1,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      points: json['points'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'name': name,
      'username': username,
      'avatar_url': avatarUrl,
      'points': points,
    };
  }
}

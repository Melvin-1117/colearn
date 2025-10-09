class User {
  final String id;
  final String? name;
  final String? email;
  final String? teamId;
  final int totalPoints;
  final DateTime createdAt;

  User({
    required this.id,
    this.name,
    this.email,
    this.teamId,
    required this.totalPoints,
    required this.createdAt,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      teamId: map['team_id'],
      totalPoints: map['total_points'] ?? 0,
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}

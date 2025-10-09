class Team {
  final String id;
  final String name;
  final String hostId;
  final DateTime createdAt;

  Team({
    required this.id,
    required this.name,
    required this.hostId,
    required this.createdAt,
  });

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'],
      name: map['name'],
      hostId: map['host_id'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}

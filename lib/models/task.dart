import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime? deadline;
  final String teamId;
  final int pointValue;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.deadline,
    required this.teamId,
    required this.pointValue,
    required this.createdAt,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      deadline: map['deadline'] != null ? (map['deadline'] as Timestamp).toDate() : null,
      teamId: map['team_id'],
      pointValue: map['point_value'] ?? 0,
      createdAt: (map['created_at'] as Timestamp).toDate(),
    );
  }
}

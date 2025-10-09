class Submission {
  final String id;
  final String userId;
  final String taskId;
  final int? score;
  final DateTime submittedAt;

  Submission({
    required this.id,
    required this.userId,
    required this.taskId,
    this.score,
    required this.submittedAt,
  });

  factory Submission.fromMap(Map<String, dynamic> map) {
    return Submission(
      id: map['id'],
      userId: map['user_id'],
      taskId: map['task_id'],
      score: map['score'],
      submittedAt: DateTime.parse(map['submitted_at']),
    );
  }
}

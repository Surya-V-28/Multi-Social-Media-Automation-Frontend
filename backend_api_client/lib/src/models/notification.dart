class Notification {
  const Notification({
    required this.id,
    required this.userId,
    required this.type,
    required this.createdAt,
    required this.message,
    required this.details,
    required this.read,
  });

  static Notification fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      createdAt: DateTime.parse(json['createdAt']),
      message: json['message'],
      details: json['details'],
      read: json['read'],
    );
  }


  final String id;
  final String userId;
  final String type;
  final DateTime createdAt;
  final String message;
  final Map<String, dynamic>? details;
  final bool read;
}

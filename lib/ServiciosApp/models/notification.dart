import 'package:familylost_faan/utilities/enum/notification_state.dart';

class Notification {
  String id;
  String title;
  Map<String, String> content;
  Map<String, NotificationState> userStates;
  String imageUrl;
  DateTime? createdAt;

  Notification({
    required this.id,
    required this.title,
    required this.content,
    required this.userStates,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] as String,
      title: json['title'] as String,
      content: Map<String, String>.from(json['content'] as Map),
      userStates: (json['userStates'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(
          key,
          NotificationState.values.firstWhere((e) => e.toString() == 'NotificationState.$value'),
        ),
      ),
      imageUrl: json['imageUrl'] as String,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'userStates': userStates.map((key, value) => MapEntry(key, value.toString().split('.').last)),
      'imageUrl': imageUrl,
      'createAt': createdAt?.toIso8601String(),
    };
  }
}
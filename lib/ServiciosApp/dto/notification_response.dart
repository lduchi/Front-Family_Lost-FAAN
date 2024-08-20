class NotificationResponse {
  String id;
  String title;
  String author;
  DateTime createdAt;
  String imageUrl;

  NotificationResponse({
    required this.id,
    required this.title,
    required this.author,
    required this.createdAt,
    required this.imageUrl,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      id: json['id'] as String,
      title: json['title'] != null ? json['title'] as String : '',
      author: json['author'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'createdAt': createdAt,
      'imageUrl': imageUrl,
    };
  }
}
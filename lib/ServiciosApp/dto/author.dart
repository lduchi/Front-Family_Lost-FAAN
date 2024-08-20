class Author {
  String id;
  String username;
  String email;
  String phone;
  String imagePath;
  String imageUrl;
  Map<String, Object?>? preferences;

  Author({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    this.imagePath = '',
    this.imageUrl = '',
    this.preferences,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      imagePath: json['imagePath'] != null ? json['imagePath'] : '',
      imageUrl: json['imageUrl'] != null ? json['imageUrl'] : '',
      preferences: json['preferences'] != null
          ? Map<String, Object?>.from(json['preferences'])
          : new Map<String, Object>(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['imageUrl'] = this.imageUrl;
    data['imagePath'] = this.imagePath;
    return data;
  }
}

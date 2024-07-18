import 'dart:convert';
import 'dart:typed_data';

class Author {
  String id;
  String username;
  String email;
  String phone;
  String imageUrl;

  Author({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    this.imageUrl = '',
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      imageUrl: json['imageUrl'] != null ? json['imageUrl'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['imageUrl'] = this.imageUrl;
    return data;
  }

  @override
  String toString() {
    return 'id: $id, username: $username, email: $email, phone: $phone, imageUrl: $imageUrl';
  }
}

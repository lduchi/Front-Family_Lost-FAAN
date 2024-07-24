import 'package:familylost_faan/ServiciosApp/dto/geo_json.dart';

class User {
  final String id;
  final String name;
  final String lastName;
  final String username;
  final String role;
  final String phone;
  final String email;
  final GeoJson location;
  final String jwt;

  const User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.username,
    required this.role,
    required this.phone,
    required this.email,
    required this.location,
    required this.jwt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      lastName: json['lastname'] as String,
      username: json['username'] as String,
      role: json['role'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      location: GeoJson.fromJson(json['location']),
      jwt: json['jwt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'username': username,
      'role': role,
      'phone': phone,
      'email': email,
      'location': location.toJson(),
      'jwt': jwt,
    };
  }
}

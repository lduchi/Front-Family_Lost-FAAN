import 'package:familylost_faan/ServiciosApp/dto/geo_json.dart';

class User {
  String id;
  String name;
  String lastname;
  String email;
  String username;
  String password;
  String? imagePath;
  GeoJson location;
  String phone;
  String role;

  User({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.username,
    required this.password,
    required this.imagePath,
    required this.location,
    required this.phone,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      imagePath: json['imagePath'],
      location: GeoJson.fromJson(json['location']),
      phone: json['phone'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'email': email,
      'username': username,
      'password': password,
      'imagePath': imagePath,
      'location': location.toJson(),
      'phone': phone,
      'role': role,
    };
  }
}

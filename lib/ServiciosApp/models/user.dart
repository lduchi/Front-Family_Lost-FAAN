import 'package:familylost_faan/ServiciosApp/models/photo.dart';

class User {
  int id;
  String nombre;
  String apellido;
  String username;
  String password;
  String direccion;
  String telefono;
  String verificationToken;
  Photo? photo;
  String role;
  String tokenPassword;

  User({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.username,
    required this.password,
    required this.direccion,
    required this.telefono,
    required this.verificationToken,
    this.photo,
    required this.role,
    required this.tokenPassword,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      direccion: json['direccion'] as String,
      telefono: json['telefono'] as String,
      verificationToken: json['verificationToken'] as String,
      photo: json['photo'] != null ? Photo.fromJson(json['photo']) : null,
      role: json['role'] as String,
      tokenPassword: json['tokenPassword'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'username': username,
      'password': password,
      'direccion': direccion,
      'telefono': telefono,
      'verificationToken': verificationToken,
      'photo': photo?.toJson(),
      'role': role,
      'tokenPassword': tokenPassword,
    };
  }
}

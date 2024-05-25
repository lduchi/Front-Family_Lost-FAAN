import 'package:familylost_faan/ServiciosApp/models/photo.dart';

class User {
  String id;
  String nombre;
  String apellido;
  String username;
  String password;
  String email;
  String direccion;
  String telefono;
  String? verificationToken;
  Photo? photo;
  String role;
  String? tokenPassword;

  User({
    required this.id,
   this.nombre = '',
    required this.apellido,
    required this.username,
    required this.password,
    required this.email,
    required this.direccion,
    required this.telefono,
    this.verificationToken,
    this.photo,
    required this.role,
    this.tokenPassword,
  });

  User.empty()
      : id = '',
        nombre = '',
        apellido = '',
        username = '',
        password = '',
        email = '',
        direccion = '',
        telefono = '',
        verificationToken = '',
        photo = null,
        role = '',
        tokenPassword = null;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      direccion: json['direccion'] as String,
      telefono: json['telefono'] as String,
      verificationToken: json['verificationToken'] != null
          ? json['verificationToken'] as String
          : '',
      photo: json['photo'] != null ? Photo.fromJson(json['photo']) : null,
      role: json['role'] as String,
      tokenPassword: json['tokenPassword'] != null
          ? json['tokenPassword'] as String
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'username': username,
      'password': password,
      'email': email,
      'direccion': direccion,
      'telefono': telefono,
      'verificationToken': verificationToken,
      'photo': photo?.toJson(),
      'role': role,
      'tokenPassword': tokenPassword,
    };
  }
}

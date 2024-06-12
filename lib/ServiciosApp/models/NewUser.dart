import 'package:familylost_faan/ServiciosApp/dto/geo_json.dart';

class NewUser {
  String name;
  String lastname;
  String email;
  String username;
  String password;
  String repeatPassword;
  GeoJson location;
  String phone;

  NewUser({
    required this.name,
    required this.lastname,
    required this.email,
    required this.username,
    required this.password,
    required this.repeatPassword,
    required this.location,
    required this.phone,
  });

  factory NewUser.fromJson(Map<String, dynamic> json) {
    return NewUser(
      name: json['name'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      repeatPassword: json['repeatPassword'] as String,
      location: json['location'],
      phone: json['phone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastname': lastname,
      'email': email,
      'username': username,
      'password': password,
      'repeadPassword': repeatPassword,
      'location': location,
      'phone': phone,
    };
  }
}

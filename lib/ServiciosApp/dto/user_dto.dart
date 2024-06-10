import 'package:familylost_faan/ServiciosApp/dto/geo_json.dart';

class UserDTO {
  String id;
  String name;
  String lastname;
  String email;
  String username;
  String? imagePath;
  GeoJson location;
  String phone;
  String imageUrl;

  UserDTO({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.username,
    this.imagePath,
    required this.location,
    required this.phone,
    required this.imageUrl,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      email: json['email'],
      username: json['username'],
      imagePath: json['imagePath'],
      location: GeoJson.fromJson(json['location']),
      phone: json['phone'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'email': email,
      'username': username,
      'imagePath': imagePath,
      'location': location.toJson(),
      'phone': phone,
      'imageUrl': imageUrl,
    };
  }
}

import 'package:familylost_faan/ServiciosApp/dto/geo_json.dart';

@Deprecated("Replaced with UserDTO, use that instead, will be removed in next version")
class UpdateUser {
  String id;
  String name;
  String lastname;
  String username;
  String password;
  String email;
  GeoJson location;
  String phone;

  UpdateUser({
    required this.id,
    required this.name,
    required this.lastname,
    required this.username,
    required this.password,
    required this.email,
    required this.location,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': name,
      'apellido': lastname,
      'username': username,
      'password': password,
      'email': email,
      'direccion': location,
      'telefono': phone,
    };
  }
}

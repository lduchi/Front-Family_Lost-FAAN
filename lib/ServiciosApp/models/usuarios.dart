import 'dart:typed_data';

class usuarios {
  int id = 0;
  String nombre = "";
  String username = "";
  String password = "";
  String apellido = "";
  String direccion = "";
  String telefono = "";
  String email = "";
  final Uint8List foto = Uint8List(0);

  usuarios({
    required this.nombre,
    required this.apellido,
    required this.direccion,
    required this.telefono,
    required this.email,
    required this.username,
    required this.password,
   // required this.foto,
  });
}

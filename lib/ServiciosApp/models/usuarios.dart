class Usuarios {
  String nombre;
  String apellido;
  String username;
  String password;
  String email;
  String direccion;
  String telefono;

  Usuarios({
    required this.nombre,
    required this.apellido,
    required this.username,
    required this.password,
    required this.email,
    required this.direccion,
    required this.telefono,
  });

  factory Usuarios.fromJson(Map<String, dynamic> json) {
    return Usuarios(
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      direccion: json['direccion'] as String,
      telefono: json['telefono'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'username': username,
      'password': password,
      'email': email,
      'direccion': direccion,
      'telefono': telefono,
    };
  }
}

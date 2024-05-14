/**
 * Model for the user update.
 * I don't know if this is the best way to do it, but it works.
 * But the backend needs this model to update the user, not the User model, so I created this one, but again,
 * I don't know if it's the best way to do it.
 */

class UpdateUser {
  int id;
  String nombre;
  String apellido;
  String username;
  String password;
  String email;
  String direccion;
  String telefono;
  String verificationToken;

  UpdateUser({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.username,
    required this.password,
    required this.email,
    required this.direccion,
    required this.telefono,
    required this.verificationToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'verificationToken': verificationToken,
      'nombre': nombre,
      'apellido': apellido,
      'username': username,
      'password': password,
      'direccion': direccion,
      'telefono': telefono,
      'email': email,
    };
  }
}

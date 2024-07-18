class login {
  int id;
  String nombre;
  String username;
  String password;
  String? tokenPassword;

  login({
    required this.id,
    required this.nombre,
    required this.username,
    required this.password,
    required this.tokenPassword,
  });

  factory login.fromJson(Map<String, dynamic> json) {
    return login(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      tokenPassword: json['tokenPassword'] != null
          ? json['tokenPassword'] as String
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'username': username,
      'password': password,
      'tokenPassword': tokenPassword,
    };
  }
}

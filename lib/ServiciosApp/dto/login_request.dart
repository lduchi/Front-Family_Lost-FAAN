class AuthenticationRequest {
  String username;
  String password;

  AuthenticationRequest({required this.username, required this.password});

  factory AuthenticationRequest.fromJson(Map<String, dynamic> json) {
    return AuthenticationRequest(
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

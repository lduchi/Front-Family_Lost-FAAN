import 'package:familylost_faan/ServiciosApp/models/user.dart';
import 'package:familylost_faan/ServiciosApp/models/usuarios.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {

  String endPointUrl = baseUrl + '/usuario';

  Future<User> getUserByUsername(String username) async {

    var url = Uri.parse('$endPointUrl/obtenerUser/$username');
    final response = await http.get(url);

    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      final userResponse = User.fromJson(json.decode(response.body));
      print(userResponse);
      return userResponse;
    } else {
      throw Exception('Failed to load user');
    }
  }
}

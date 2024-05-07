/*Estas validaciones son para el registro del usuario*/
class ValidacionesUsuario {
  String nombre = '';
  String apellido = '';
  String direccion = '';
  String telefono = '';
  String email = '';
  String username = '';
  String password = '';

  //Sirve para mostrar los mensajes
  Map<String, String> errorMessages = {};

  //VALIDACION PARA EL NOMBRE
  static String validateNombre(String fieldName, String nombre) {
    if (nombre == false || nombre.isEmpty) {
      return fieldName + " es requerido";
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(nombre)) {
      return fieldName + " solo puede contener letras";
    }
    // Convertir la primera letra a mayúscula
    nombre = nombre.substring(0, 1).toUpperCase() + nombre.substring(1);

    return ''; // validación exitosa
  }

  //VALIDACION PARA EL APELLIDO
  static String validateApellido(String fieldName, String apellido) {
    if (apellido == false || apellido.isEmpty) {
      return fieldName + " es requerido";
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(apellido)) {
      return fieldName + " solo puede contener letras";
    }
    // Convertir la primera letra a mayúscula
    apellido = apellido.substring(0, 1).toUpperCase() + apellido.substring(1);

    return ''; // validación exitosa
  }

//VALIDACION PARA EL USERNAME DEL USUARIO
  static String validateUsername(String fieldName, String username) {
    return validateNombre(fieldName, username);
  }

//VALIDACION PARA LA CONTRASEÑA DEL USUARIO
  static String validatePassword(String fieldName, String password) {
    // Verificar la longitud mínima
    if (password.length < 8) {
      return fieldName + " debe tener al menos 8 caracteres";
    }

    // Al menos una letra minúscula
    if (!RegExp(r'.*[a-z].*').hasMatch(password)) {
      return fieldName + " debe contener al menos una letra minúscula";
    }

    // Al menos una letra mayúscula
    if (!RegExp(r'.*[A-Z].*').hasMatch(password)) {
      return fieldName + " debe contener al menos una letra mayúscula";
    }

    // Al menos un dígito
    if (!RegExp(r'.*\d.*').hasMatch(password)) {
      return fieldName + " debe contener al menos un dígito";
    }

    // Al menos un carácter especial
    if (!RegExp(r'.*[@#$%&].*').hasMatch(password)) {
      return fieldName + " debe contener al menos un carácter especial";
    }

    return ''; // validación exitosa, no hay mensajes de error
  }

  static String validateDireccion(String fieldName, String direccion) {
    if (direccion == false || direccion.trim().isEmpty) {
      return fieldName + " no puede estar vacía";
    }

    return ''; // validación exitosa
  }

//VALIDACION PARA EL TELEFONO
  static String validateTelefono(String fieldName, String telefono) {
    if (telefono == false || telefono.length != 10) {
      return fieldName + " debe tener exactamente 10 dígitos";
    }

    if (!RegExp(r'\d+').hasMatch(telefono)) {
      return fieldName + " debe contener solo dígitos";
    }

    if (!telefono.startsWith("0")) {
      return fieldName + " debe empezar con 0";
    }

    return ''; // validación exitosa
  }

//VALIDACION PARA EL EMAIL
  static String validateEmail(String email) {
    if (email == false ||
        !RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
            .hasMatch(email)) {
      return "Correo electrónico no válido";
    }

    return ''; // validación exitosa
  }
}

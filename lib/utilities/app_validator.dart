import 'package:familylost_faan/ServiciosApp/services/user_service.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';

/**
 * AppValidator class is used to validate the user input fields.
 * It contains static methods to validate email, password, name, last name, phone, username, description, and title.
 * Each method returns a string with the error message if the input is invalid, otherwise it returns null.
 * The error messages are defined in the AppStrings class.
 */

class AppValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AppStrings.errorEmptyEmail;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return AppStrings.errorEmail;
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AppStrings.errorEmptyPassword;
    }
    if (password.length < 6) {
      return AppStrings.errorPasswordLength;
    }
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$').hasMatch(password)) {
      return AppStrings
          .errorPassword; // Needs to be define correctly in the AppStrings class, the message is not clear.
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return AppStrings.errorEmptyConfirmPassword;
    }
    if (confirmPassword != password) {
      return AppStrings.errorConfirmPassword;
    }
    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return AppStrings.errorEmptyName;
    }
    if (name.length < 3) {
      return AppStrings.errorNameLength;
    }
    // if (name.length > 50) {
    //   return 'Name must be less than 50 characters';
    // }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
      return AppStrings.errorName;
    }

    return null;
  }

  static String? validateLastName(String? lastName) {
    if (lastName == null || lastName.isEmpty) {
      return AppStrings.errorEmptyLastName;
    }
    if (lastName.length < 3) {
      return AppStrings.errorLastNameLength;
    }
    // if (lastName.length > 50) {
    //   return 'Last name must be less than 50 characters';
    // }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(lastName)) {
      return AppStrings.errorLastName;
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return AppStrings.errorEmptyPhone;
    }
    if (phone.length < 10) {
      return AppStrings.errorPhoneLength;
    }
    if (phone.length > 10) {
      return 'Phone must be 10 characters'; // Needs to be define correctly in the AppStrings class, the message is defined here.
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      return AppStrings.errorPhone;
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return AppStrings.errorEmptyUsername;
    }
    if (username.length < 3) {
      return AppStrings.errorUsernameLength;
    }
    // if (username.length > 50) {
    //   return 'Username must be less than 50 characters';
    // }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username)) {
      return 'Username must contain only letters and numbers'; // Needs to be define correctly in the AppStrings class, the message is defined here.
    }
    return null;
  }

  /**
   * I don't know if the following methods are used in the project, but they are not defined in the AppStrings class.
   * If they are used, they are defined here, otherwise they can be removed.
   * The AppStrings class contains generic error messages that can be used here, I you need to change the error messages, you can define them in the AppStrings class.
   */

  static String? validateDescription(String? description) {
    if (description == null || description.isEmpty) {
      return 'Description is required';
    }
    if (description.length < 10) {
      return 'Description must be at least 10 characters';
    }
    if (description.length > 200) {
      return 'Description must be less than 200 characters';
    }
    return null;
  }

  static String? validateTitle(String? title) {
    if (title == null || title.isEmpty) {
      return 'Title is required';
    }
    if (title.length < 3) {
      return 'Title must be at least 3 characters';
    }
    if (title.length > 50) {
      return 'Title must be less than 50 characters';
    }
    return null;
  }

  Future<bool> existsEmail(String email) async {
    return await UserService().existsByEmail(email);
  }

  Future<bool> existsUsername(String username) async {
    return await UserService().existsByUsername(username);
  }

  Future<bool> existsPhone(String phone) async {
    return await UserService().existsByPhone(phone);
  }
}

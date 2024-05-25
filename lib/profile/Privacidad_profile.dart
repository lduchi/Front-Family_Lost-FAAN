import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/models/user.dart';
import 'package:familylost_faan/ServiciosApp/services/user_service.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/app_validator.dart';
import 'package:familylost_faan/utilities/icons/app_icons.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart'; // Importa la clase AppFonts

class PrivacidadProfile extends StatefulWidget {
  const PrivacidadProfile({super.key});

  @override
  State<PrivacidadProfile> createState() => _PrivacidadProfileState();
}

class _PrivacidadProfileState extends State<PrivacidadProfile> {
  final _formKey = GlobalKey<FormState>();
  User? user;
  String? userId;
  bool _passwordInVisible = true;

  final _passwordTextController = TextEditingController();
  final _repeatPasswordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getStoredId();
  }

  Future<String?> _getStoredId() async {
    userId = await Store.getUserId();
    return userId;
  }

  Future<bool> _updatePassword() async {
    var newPassword = _passwordTextController.text;
    if (_formKey.currentState!.validate()) {
      if (newPassword == _repeatPasswordTextController.text) {
        bool response =
            await UserService().updatePassword(userId!, newPassword);
        return response;
      }
    }
    return false;
  }

  void _showOrHidePassword() {
    setState(() {
      _passwordInVisible = !_passwordInVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.updatePassword,
          style: AppFonts.title,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10),
                _buildPasswordFieldWithIcon(
                  AppIcons.lockIcon,
                  AppStrings.newPassword,
                  AppFonts.TextField,
                  _passwordTextController,
                  //validator: AppValidator.validatePassword,
                ),
                SizedBox(height: 10),
                _buildPasswordFieldWithIcon(
                  AppIcons.lockIcon,
                  AppStrings.repeatPassword,
                  AppFonts.TextField,
                  _repeatPasswordTextController,
                  validator: (value) {
                    if (value != _passwordTextController.text) {
                      return AppStrings.errorConfirmPassword;
                    }
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _updatePassword().then((value) {
                        if (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Password updated'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error updating password'),
                            ),
                          );
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF009AB0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      AppStrings.updatePassword,
                      style: AppFonts.button,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPasswordFieldWithIcon(
    Icon icon,
    String label,
    TextStyle textStyle,
    TextEditingController controller, {
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        obscureText: _passwordInVisible,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon,
          suffixIcon: IconButton(
            icon: _passwordInVisible
                ? AppIcons.eyeShowIcon
                : AppIcons.eyeHideIcon,
            onPressed: () {
              _showOrHidePassword();
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Color(0xFF707070)),
          ),
        ),
        controller: controller,
        validator: validator,
      ),
    );
  }
}

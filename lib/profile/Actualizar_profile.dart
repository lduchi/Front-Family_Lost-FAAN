import 'package:familylost_faan/ServiciosApp/models/user.dart';
import 'package:familylost_faan/ServiciosApp/services/user_service.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart'; // Importa la clase AppFonts
import 'dart:developer' as developer;

class ActualizarProfile extends StatefulWidget {
  const ActualizarProfile({super.key});

  @override
  State<ActualizarProfile> createState() => _ActualizarProfileState();
}

class _ActualizarProfileState extends State<ActualizarProfile> {
  late User? user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    try {
      user = await UserService().getUserByUsername('mike');
      setState(() {});
    } catch (e, stackTrace) {
      developer.log('Error fetching user: $e',
          name: '_getUser', stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Actualizar Perfil',
          style: AppFonts.title, // Usa el estilo de título de AppFonts
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Container(
            height: 150,
            child: CircleAvatar(
              radius: 80,
              backgroundImage: Image.memory(
                user!.photo!.image.data,
              ).image,
            ),
          ),
          SizedBox(height: 16),
          _buildTextFieldWithIcon(
              CupertinoIcons.person,
              AppStrings.labelName,
              AppFonts.TextField.copyWith(
                color: AppColors.activeBlueColor,
              ),
              user!.nombre),
          SizedBox(height: 5),
          _buildTextFieldWithIcon(
              CupertinoIcons.person,
              AppStrings.labelLastName,
              AppFonts.TextField.copyWith(
                color: AppColors.activeBlueColor,
              ),
              user!.apellido),
          SizedBox(height: 5),
          _buildTextFieldWithIcon(
              CupertinoIcons.phone,
              AppStrings.labelPhone,
              AppFonts.TextField.copyWith(
                color: AppColors.activeBlueColor,
              ),
              user!.telefono),
          SizedBox(height: 5),
          _buildTextFieldWithIcon(
              CupertinoIcons.mail,
              AppStrings.labelEmail,
              AppFonts.TextField.copyWith(
                color: AppColors.activeBlueColor,
              ),
              user!.email),
          SizedBox(height: 5),
          _buildTextFieldWithIcon(
              CupertinoIcons.at,
              AppStrings.username,
              AppFonts.TextField.copyWith(
                color: AppColors.activeBlueColor,
              ),
              user!.username),
          SizedBox(height: 5),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Implementa la lógica para validar y procesar el registro
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                "Guardar Cambios",
                style: AppFonts.button,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithIcon(
      IconData icon, String label, TextStyle textStyle, String data) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        initialValue: data,
        style: textStyle, // Usa el estilo de texto proporcionado
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Color(0xFF707070)),
          ),
        ),
      ),
    );
  }
}

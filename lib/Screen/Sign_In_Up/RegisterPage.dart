import 'dart:io';
import 'package:familylost_faan/ServiciosApp/models/usuarios.dart';
import 'package:familylost_faan/ServiciosApp/services/register_service.dart';
import 'package:familylost_faan/core/utils/show_messages.dart';
import 'package:familylost_faan/core/utils/text_input.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/widgets/RegisterPageAppBar.dart';
import 'package:familylost_faan/widgets/custom_quick_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passRepeatController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    direccionController.dispose();
    telefonoController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passRepeatController.dispose();
    super.dispose();
  }

  File? imageFile;
  final picker = ImagePicker();

  bool isPasswordVisible = true;

  final apiService = UsuariosService();

  Future<void> _getImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegisterPageAppBar(),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(20),
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: imageFile != null
                      ? Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.upload_file,
                          size: 50,
                          color: Colors.grey,
                        ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getImage,
                child: Text("Seleccionar foto de perfil"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF009AB0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomTextInput(
                  controller: nombreController,
                  label: "Nombre",
                  icon: CupertinoIcons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo de nombre vacio";
                    }
                    final RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
                    if (!nameRegex.hasMatch(value)) {
                      return 'Nombre solo debe contener letras';
                    }
                    return null;
                  }),
              SizedBox(height: 10),
              CustomTextInput(
                  controller: apellidoController,
                  label: "Apellido",
                  icon: CupertinoIcons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo de apellidos vacio";
                    }
                    final RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
                    if (!nameRegex.hasMatch(value)) {
                      return 'Apellido solo debe contener letras';
                    }
                    return null;
                  }),
              SizedBox(height: 10),
              CustomTextInput(
                  controller: direccionController,
                  label: "Dirección",
                  icon: CupertinoIcons.location,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo de dirección vacio";
                    }
                    final RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
                    if (!nameRegex.hasMatch(value)) {
                      return 'Dirección solo debe contener letras';
                    }
                    return null;
                  }),
              SizedBox(height: 10),
              CustomTextInput(
                  controller: telefonoController,
                  label: "Telefono",
                  icon: CupertinoIcons.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo de telefono vacio";
                    }
                    final RegExp phoneRegex = RegExp(r'^[0-9]{10,13}$');
                    if (!phoneRegex.hasMatch(value)) {
                      return 'Telefono solo debe contener numeros';
                    }

                    return null;
                  }),
              SizedBox(height: 10),
              CustomTextInput(
                  controller: emailController,
                  label: "Correo Electronico",
                  icon: CupertinoIcons.mail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo de email vacio";
                    }
                    final RegExp emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Formato de email incorrecto';
                    }

                    return null;
                  }),
              SizedBox(height: 10),
              CustomTextInput(
                  controller: usernameController,
                  label: "Username",
                  icon: CupertinoIcons.at,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo de username vacio";
                    }
                    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9]+$');
                    if (!usernameRegex.hasMatch(value)) {
                      return 'Username solo contener letras y numeros';
                    }

                    return null;
                  }),
              SizedBox(height: 10),
              CustomTextInput(
                controller: passwordController,
                label: "Contraseña",
                icon: CupertinoIcons.lock,
                isShow: true,
                isPassword: isPasswordVisible,
                onChanges: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                validator: _validatePassword,
              ),
              SizedBox(height: 10),
              CustomTextInput(
                controller: passRepeatController,
                label: "Repetir Contraseña",
                icon: CupertinoIcons.lock,
                isShow: true,
                isPassword: isPasswordVisible,
                onChanges: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                validator: (value) {
                  String? passwordError = _validatePassword(value);
                  String? passwordMatchError = _validatePasswordMatch(value);
                  return passwordError ?? passwordMatchError;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    SaveUser();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF009AB0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    "Registrarse",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.01),
              child: Center(
                child:
                    LoadingAnimationWidget.inkDrop(color: Colors.red, size: 50),
              ),
            ),
        ],
      ),
    );
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo de contraseña vacio";
    }
    final RegExp passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'La contraseña debe contener al menos una letra en mayúscula, un número y un carácter especial, y tener al menos 8 caracteres';
    }
    return null;
  }

  String? _validatePasswordMatch(String? value) {
    if (value != passwordController.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  void SaveUser() async {
    String nombre_ = nombreController.text;
    String apellido_ = apellidoController.text;
    String direccion_ = direccionController.text;
    String telefono_ = telefonoController.text;
    String email_ = emailController.text;
    String username_ = usernameController.text;
    String password_ = passRepeatController.text;

    if (imageFile == null) {
      showFieldError(context, "Image");
      return;
    } else {
      Usuarios userNuevo = Usuarios(
        nombre: nombre_,
        apellido: apellido_,
        direccion: direccion_,
        telefono: telefono_,
        email: email_,
        username: username_,
        password: password_,
      );

      final UsuariosService apiService = UsuariosService();
      FocusScope.of(context).unfocus();
      setState(() {
        isLoading = true;
      });
      try {
        await apiService.saveUser(userNuevo, imageFile!, context);
        setState(() {
          isLoading = false;
        });
        CustomMaterialDialog.successOrError(
            context: context,
            type: DialogType.loading,
            title: "¡Hey!",
            message: "Gracias por registrarte ");
      } catch (e) {
        print('Error al guardar al registro: $e');
        setState(() {
          isLoading = false;
        });
        CustomMaterialDialog.successOrError(
            context: context,
            type: DialogType.error,
            title: "Whoops..",
            message: "Estamos teniendo problemas una disculpa ");
      }
    }
  }
}

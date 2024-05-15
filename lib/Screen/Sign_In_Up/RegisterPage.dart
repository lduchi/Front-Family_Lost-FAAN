import 'dart:io';
import 'package:familylost_faan/ServiciosApp/models/usuarios.dart';
import 'package:familylost_faan/ServiciosApp/services/register_service.dart';
import 'package:familylost_faan/core/utils/show_messages.dart';
import 'package:familylost_faan/core/utils/text_input.dart';
import 'package:familylost_faan/widgets/RegisterPageAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

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
      body: ListView(
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
              label: "Nombres",
              icon: CupertinoIcons.person),
          SizedBox(height: 10),
          CustomTextInput(
              controller: apellidoController,
              label: "Apellidos",
              icon: CupertinoIcons.person),
          SizedBox(height: 10),
          CustomTextInput(
              controller: direccionController,
              label: "Direccion",
              icon: CupertinoIcons.location),
          SizedBox(height: 10),
          CustomTextInput(
              controller: telefonoController,
              label: "Telefono",
              icon: CupertinoIcons.phone),
          SizedBox(height: 10),
          CustomTextInput(
              controller: direccionController,
              label: "Direccion",
              icon: CupertinoIcons.mail),
          SizedBox(height: 10),
          CustomTextInput(
              controller: usernameController,
              label: "Username",
              icon: CupertinoIcons.at),
          SizedBox(height: 10),
          CustomTextInput(
            controller: passwordController,
            label: "Contraseña",
            icon: CupertinoIcons.lock,
            isShow: true,
            isPassword: isPasswordVisible,
            onChanges: () {
              print("Estoy llegando");
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
          SizedBox(height: 10),
          CustomTextInput(
            controller: passRepeatController,
            label: "Repetir Contraseña",
            icon: CupertinoIcons.lock,
            isShow: true,
            isPassword: isPasswordVisible,
            onChanges: () {
              print("Estoy llegando");
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
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
    );
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
    }
    if (nombre_.isEmpty) {
      showFieldError(context, "Nombre");
    } else if (apellido_.isEmpty) {
      showFieldError(context, "Apellido");
    } else if (direccion_.isEmpty) {
      showFieldError(context, "Direccion");
    } else if (telefono_.isEmpty) {
      showFieldError(context, "Telefono");
    } else if (email_.isEmpty) {
      showFieldError(context, "Correo Electronico");
    } else if (username_.isEmpty) {
      showFieldError(context, "Username");
    } else if (password_.isEmpty) {
      showFieldError(context, "Password");
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
      try {
        await apiService.saveUser(userNuevo, imageFile!, context);
        print('Publicacion guardada ');
      } catch (e) {
        print('Error al guardar la publicación: $e');
      }
    }
  }
}

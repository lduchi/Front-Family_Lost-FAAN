import 'dart:io';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/models/user.dart';
import 'package:familylost_faan/ServiciosApp/models/user_update.dart';
import 'package:familylost_faan/ServiciosApp/services/user_service.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/app_validator.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'dart:developer' as developer;
import 'package:image_picker/image_picker.dart';

class ActualizarProfile extends StatefulWidget {
  const ActualizarProfile({super.key});

  @override
  State<ActualizarProfile> createState() => _ActualizarProfileState();
}

class _ActualizarProfileState extends State<ActualizarProfile> {
  final _formKey = GlobalKey<FormState>();
  var _deviceSize;
  User? user;
  late File? _selectedImage = null;
  BigInt? userId;

  final _imagePicker = ImagePicker();
  final _nameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getStoredId().then((value) {
      userId = value;
      _getUser();
    });
  }

  void _initControllers() {
    if (user != null) {
      _nameTextController.text = user!.nombre;
      _lastNameTextController.text = user!.apellido;
      _phoneTextController.text = user!.telefono;
      _emailTextController.text = user!.email;
      _usernameTextController.text = user!.username;
    }
  }

  Future<BigInt?> _getStoredId() async {
    userId = await Store.getUserId();
    return userId;
  }

  void _getUser() async {
    user = await UserService().getUserById(userId!, context);
    setState(() {
      _initControllers();
    });
  }

  void _updatePhoto(String username, File file) async {
    try {
      await UserService().updatePhoto(username, file);
    } catch (e, stackTrace) {
      developer.log('Error uploading photo: $e',
          name: '_updatePhoto', stackTrace: stackTrace);
    }
  }

  void _updateUser() async {
    if (_formKey.currentState!.validate()) {
      UpdateUser updateUser = UpdateUser(
        id: user!.id,
        verificationToken: user!.verificationToken,
        nombre: _nameTextController.text,
        apellido: _lastNameTextController.text,
        username: _usernameTextController.text,
        password: user!.password,
        email: _emailTextController.text,
        direccion: user!.direccion,
        telefono: _phoneTextController.text,
      );
      if (_selectedImage != null) {
        _updatePhoto(updateUser.username, _selectedImage!);
      }
      await UserService().updateUser(updateUser.id, updateUser);
      setState(() {
        _getUser();
      });
    }
  }

  Future<void> _imageChooser() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;

    if (user == null) {
      return Container(
        color: AppColors.secondaryMainColor,
        child: Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(AppColors.activeBlueColor),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.updateProfile,
          style: AppFonts.title,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(_deviceSize.width * 0.05),
        children: [
          IconButton(
            onPressed: _imageChooser,
            icon: CircleAvatar(
              radius: _deviceSize.width * 0.2,
              backgroundImage: _selectedImage != null
                  ? FileImage(_selectedImage!)
                  : Image.memory(user!.photo!.image.data).image,
            ),
            iconSize: _deviceSize.width * 0.4,
          ),
          SizedBox(height: _deviceSize.height * 0.01),
          Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  _buildTextFieldWithIcon(
                    CupertinoIcons.person,
                    TextInputType.name,
                    AppStrings.labelName,
                    AppFonts.TextField.copyWith(
                      color: AppColors.activeBlueColor,
                    ),
                    _nameTextController,
                    validator: AppValidator.validateName,
                  ),
                  SizedBox(height: _deviceSize.height * 0.01),
                  _buildTextFieldWithIcon(
                    CupertinoIcons.person,
                    TextInputType.name,
                    AppStrings.labelLastName,
                    AppFonts.TextField.copyWith(
                      color: AppColors.activeBlueColor,
                    ),
                    _lastNameTextController,
                    validator: AppValidator.validateLastName,
                  ),
                  SizedBox(height: _deviceSize.height * 0.01),
                  _buildTextFieldWithIcon(
                    CupertinoIcons.phone,
                    TextInputType.phone,
                    AppStrings.labelPhone,
                    AppFonts.TextField.copyWith(
                      color: AppColors.activeBlueColor,
                    ),
                    _phoneTextController,
                    validator: AppValidator.validatePhone,
                  ),
                  SizedBox(height: _deviceSize.height * 0.01),
                  _buildTextFieldWithIcon(
                    CupertinoIcons.mail,
                    TextInputType.emailAddress,
                    AppStrings.labelEmail,
                    AppFonts.TextField.copyWith(
                      color: AppColors.activeBlueColor,
                    ),
                    _emailTextController,
                    validator: AppValidator.validateEmail,
                  ),
                  SizedBox(height: _deviceSize.height * 0.01),
                  _buildTextFieldWithIcon(
                    CupertinoIcons.at,
                    TextInputType.name,
                    AppStrings.username,
                    AppFonts.TextField.copyWith(
                      color: AppColors.activeBlueColor,
                    ),
                    _usernameTextController,
                    validator: AppValidator.validateUsername,
                  ),
                ],
              )),
          SizedBox(height: _deviceSize.height * 0.01),
          SizedBox(
            height: _deviceSize.height * 0.08,
            child: ElevatedButton(
              onPressed: () {
                _updateUser();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                AppStrings.buttonSave,
                style: AppFonts.button,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithIcon(
    IconData icon,
    TextInputType inputType,
    String label,
    TextStyle textStyle,
    TextEditingController? controller, {
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        style: textStyle,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide:
                BorderSide(color: AppColors.activeBlueColor, width: 2.0),
          ),
        ),
        controller: controller,
        validator: validator,
      ),
    );
  }
}

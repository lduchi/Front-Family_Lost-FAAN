import 'dart:async';
import 'dart:io';
import 'package:familylost_faan/ServiciosApp/dto/geo_json.dart';
import 'package:familylost_faan/ServiciosApp/models/NewUser.dart';
import 'package:familylost_faan/ServiciosApp/services/register_service.dart';
import 'package:familylost_faan/core/utils/text_input.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:familylost_faan/widgets/RegisterPageAppBar.dart';
import 'package:familylost_faan/widgets/custom_quick_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  TextEditingController passRepeadController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  LatLng? currentCenterPosition;

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
    passRepeadController.dispose();
    super.dispose();
  }

  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-2.8973852640959343, -79.00446994564442),
    zoom: 14.4746,
  );

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
                controller: passRepeadController,
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
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _openMapScreen(context);
                },
                child: Text(AppStrings.formLocationUser),
              ),
              SizedBox(height: 5),
              FutureBuilder<String>(
                future: currentCenterPosition != null
                    ? getAddressFromCoordinates(currentCenterPosition!.latitude,
                        currentCenterPosition!.longitude)
                    : null,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return TextFormField(
                      readOnly: true,
                      controller: TextEditingController(text: snapshot.data),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.errorLocation;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: currentCenterPosition != null
                            ? AppStrings.formLocationSelectedUser
                            : AppStrings.formEmptyLocationSelectedUser,
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(Icons.location_on),
                        ),
                      ),
                    );
                  } else {
                    return TextFormField(
                      readOnly: true,
                      controller: TextEditingController(text: ''),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.errorLocation;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: AppStrings.formEmptyLocationSelectedUser,
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(Icons.location_on),
                        ),
                      ),
                    );
                  }
                },
              ),
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

  void _openMapScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.messageMapLocation,
              style: AppFonts.TitlePost,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              color: AppColors.icnColor,
            ),
            backgroundColor: AppColors.secondaryMainColor,
          ),
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: _cameraPosition,
                mapType: MapType.terrain,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onCameraMove: (CameraPosition position) {
                  currentCenterPosition = position.target;
                },
              ),
              Center(
                child: Icon(
                  Icons.gps_not_fixed_sharp,
                  color: AppColors.icnColor,
                  size: 25,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (currentCenterPosition != null) {
                _saveLocation(currentCenterPosition!);
              }
            },
            label: Text(AppStrings.messageSelectLocation),
            icon: Icon(Icons.location_on_outlined),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      }),
    );
  }

  void _saveLocation(LatLng location) {
    print('Ubicación seleccionada: $location');
    setState(() {
      currentCenterPosition = location;
      Navigator.pop(context);
    });
  }

  void SaveUser() async {
    double longitude = currentCenterPosition!.longitude;
    double latitude = currentCenterPosition!.latitude;

    GeoJson geoJsonLocation = GeoJson(
      x: 2,
      y: 3,
      type: 'Point',
      coordinates: [longitude, latitude],
    );

    String name_ = nombreController.text;
    String lastname_ = apellidoController.text;
    String email_ = emailController.text;
    String username_ = usernameController.text;
    String password_ = passwordController.text;
    String repeatPassword_ = passRepeadController.text;
    String phone_ = telefonoController.text;

    if (imageFile == null) {
      CustomMaterialDialog.successOrError(
        context: context,
        type: DialogType.error,
        title: AppStrings.textErrorTitle,
        message: 'Por favor selecciona una foto',
      );
      return;
    } else {
      NewUser userNuevo = NewUser(
        name: name_,
        lastname: lastname_,
        email: email_,
        username: username_,
        password: password_,
        repeatPassword: repeatPassword_,
        location: geoJsonLocation,
        phone: phone_,
      );

      final UsuariosService apiService = UsuariosService();
      FocusScope.of(context).unfocus();
      setState(() {
        isLoading = true;
      });
      try {
        await apiService.Register(userNuevo, imageFile!, context);
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

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}';
      }
    } catch (e) {
      print('Error: $e');
    }
    return '';
  }
}

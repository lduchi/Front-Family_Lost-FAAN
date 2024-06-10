import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:familylost_faan/ServiciosApp/dto/geo_json.dart';
import 'package:familylost_faan/ServiciosApp/dto/user_dto.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/services/user_service.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/app_validator.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ActualizarProfile extends StatefulWidget {
  const ActualizarProfile({super.key});

  @override
  State<ActualizarProfile> createState() => _ActualizarProfileState();
}

class _ActualizarProfileState extends State<ActualizarProfile> {
  final _formKey = GlobalKey<FormState>();
  var _deviceSize;
  UserDTO? user;
  late File? _selectedImage = null;
  String? userId;
  Marker? _userMarker;
  late GoogleMapController _mapController;

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

  @override
  void dispose() {
    _nameTextController.dispose();
    _lastNameTextController.dispose();
    _phoneTextController.dispose();
    _emailTextController.dispose();
    _usernameTextController.dispose();
    super.dispose();
  }

  void _initControllers() {
    if (user != null) {
      _nameTextController.text = user!.name;
      _lastNameTextController.text = user!.lastname;
      _phoneTextController.text = user!.phone;
      _emailTextController.text = user!.email;
      _usernameTextController.text = user!.username;
    }
  }

  Future<String?> _getStoredId() async {
    userId = await Store.getUserId();
    return userId;
  }

  void _getUser() async {
    user = await UserService().getUserById(userId!, context);
    setState(() {
      _initControllers();
    });
  }

  void _updatePhoto(String username, File file, BuildContext context) async {
    await UserService().updatePhoto(username, file, context);
  }

  void _updateUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      UserDTO updateUser = UserDTO(
        id: user!.id,
        name: _nameTextController.text,
        lastname: _lastNameTextController.text,
        username: _usernameTextController.text,
        location: GeoJson(
          x: 2,
          y: 3,
          type: 'Point',
          coordinates: [
            _userMarker!.position.longitude,
            _userMarker!.position.latitude,
          ],
        ),
        email: _emailTextController.text,
        phone: _phoneTextController.text,
        imageUrl: user!.imageUrl,
      );
      if (_selectedImage != null) {
        _updatePhoto(updateUser.username, _selectedImage!, context);
      }
      await UserService().updateUser(updateUser.id, updateUser, context);
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
                  : user?.imageUrl != null
                      ? CachedNetworkImageProvider(user!.imageUrl)
                      : AssetImage(AssetManager.largeLogo)
                          as ImageProvider<Object>?,
            ),
            iconSize: _deviceSize.width * 0.4,
          ),
          SizedBox(height: _deviceSize.height * 0.01),
          _updateForm(),
          SizedBox(height: _deviceSize.height * 0.01),
          SizedBox(
            height: _deviceSize.height * 0.08,
            child: ElevatedButton(
              onPressed: () {
                _updateUser(context);
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

  Form _updateForm() {
    return Form(
      key: _formKey,
      //autovalidateMode: AutovalidateMode.onUserInteraction,
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
          SizedBox(height: _deviceSize.height * 0.01),
          ConstrainedBox(
              constraints: BoxConstraints(maxHeight: _deviceSize.height * 0.3),
              child: _buildMap(user!.location)),
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

  Widget _buildMap(GeoJson location) {
    LatLng userLocation =
        LatLng(location.coordinates[1], location.coordinates[0]);
    Set<Marker> markers = {};
    if (_userMarker != null) {
      markers.add(_userMarker!);
    } else {
      _userMarker = Marker(
        markerId: MarkerId('user_location'),
        position: userLocation,
        infoWindow: InfoWindow(
          title: 'Your Location',
        ),
      );
      markers.add(_userMarker!);
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: userLocation,
        zoom: 15,
      ),
      markers: markers,
      onMapCreated: (controller) {
        _mapController = controller;
      },
      onTap: (LatLng tappedPoint) {
        setState(
          () {
            _userMarker = Marker(
              markerId: MarkerId('user_location'),
              position: tappedPoint,
              infoWindow: InfoWindow(
                title: 'Selected Location',
              ),
            );
            markers.clear();
            markers.add(_userMarker!);
            print('Tapped Point');
            print(tappedPoint);
          },
        );
      },
    );
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

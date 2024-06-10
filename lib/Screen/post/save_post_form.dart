import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:familylost_faan/ServiciosApp/dto/animal.dart';
import 'package:familylost_faan/ServiciosApp/dto/author.dart';
import 'package:familylost_faan/ServiciosApp/dto/geo_json.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/services/post_service.dart';
import 'package:familylost_faan/ServiciosApp/utils/animal_list.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/utilities/colors/app_colors.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/utilities/enum/post_type.dart';
import 'package:familylost_faan/utilities/enum/state_post.dart';
import 'package:familylost_faan/utilities/fonts/app_fonts.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:familylost_faan/widgets/custom_quick_alert.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SavePostForm extends StatefulWidget {
  final PostType typePost;
  final Author author;
  final StatePost statePost;

  const SavePostForm({
    super.key,
    required this.typePost,
    required this.author,
    required this.statePost,
  });

  @override
  _SavePostFormState createState() => _SavePostFormState(
      typePost: typePost, author: author, statePost: statePost);
}

class _SavePostFormState extends State<SavePostForm> {
  final PostType typePost;
  final Author author;
  final StatePost statePost;

  final api = PostService();
  bool showOtherBreedTextField = false;

  Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentCenterPosition;
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  final picker = ImagePicker();
  final _titleController = TextEditingController();
  DateTime? _selectedDate;
  final _additionalCommentController = TextEditingController();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _raceController = TextEditingController();
  final _genderController = TextEditingController();

  _SavePostFormState({
    required this.typePost,
    required this.author,
    required this.statePost,
  });

  Future<void> _getImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(-2.8973852640959343, -79.00446994564442),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryMainColor,
        title: Text(
          AppStrings.formTitle,
          style: AppFonts.TitlePost,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            CustomMaterialDialog.warningWithOptions(
              context: context,
              type: DialogType.warning,
              title: AppStrings.textAttentionTitle,
              message: AppStrings.textAttentionMessage,
            );
          },
          color: AppColors.icnColor,
        ),
        actions: [
          TextButton(
            onPressed: () {
              _savePost();
            },
            child: Text(
              AppStrings.postActionTitle,
              style: TextStyle(
                color: AppColors.icnColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 90,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: CachedNetworkImageProvider(
                          author.imageUrl.isNotEmpty
                              ? author.imageUrl
                              : AssetManager.largeLogo,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            author.username.toUpperCase(),
                            style: AppFonts.TitlePost,
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            style: AppFonts.InputTitlePost,
                            textCapitalization: TextCapitalization.characters,
                            controller: _titleController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.errorTitle;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: AppStrings.formTitlePost,
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: _selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                        : '',
                  ),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null && pickedDate != _selectedDate) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.errorDate;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: typePost.name == 'LOST'
                        ? AppStrings.formLostDate
                        : AppStrings.formViewedDate,
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.errorAnimalName;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: AppStrings.formName,
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.pets),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _typeController.text.isNotEmpty
                      ? _typeController.text
                      : null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.errorType;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: AppStrings.formType,
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.pets),
                    ),
                  ),
                  items: [
                    ...animalLists.map((animal) {
                      return DropdownMenuItem<String>(
                        value: animal.name.toLowerCase(),
                        child: Text(animal.name),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _typeController.text = value!;
                      if (value.toLowerCase() == 'other') {
                        _raceController.text = 'Other';
                        showOtherBreedTextField = true;
                      } else {
                        showOtherBreedTextField = false;
                        _raceController.clear();
                      }
                    });
                  },
                ),
                SizedBox(height: 16),
                if (showOtherBreedTextField)
                  TextFormField(
                    controller: _raceController,
                    decoration: InputDecoration(
                      labelText: AppStrings.formBreed,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.pets),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.errorBreed;
                      }
                      return null;
                    },
                  ),
                if (!showOtherBreedTextField)
                  DropdownButtonFormField<String>(
                    value: _raceController.text.isNotEmpty
                        ? _raceController.text
                        : null,
                    validator: (value) {
                      if (!showOtherBreedTextField &&
                          (value == null || value.isEmpty)) {
                        return AppStrings.errorBreed;
                      }
                      return null;
                    },
                    autovalidateMode: showOtherBreedTextField
                        ? AutovalidateMode.disabled
                        : AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: AppStrings.formBreed,
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.pets),
                      ),
                    ),
                    items: _typeController.text.isNotEmpty &&
                            !showOtherBreedTextField
                        ? animalLists
                            .firstWhere((animal) =>
                                animal.name.toLowerCase() ==
                                _typeController.text.toLowerCase())
                            .breeds
                            .map((breed) {
                            return DropdownMenuItem<String>(
                              value: breed,
                              child: Text(breed),
                            );
                          }).toList()
                        : [],
                    onChanged: (value) {
                      setState(() {
                        _raceController.text = value!;
                      });
                    },
                  ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _genderController.text.isNotEmpty
                      ? _genderController.text
                      : null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.errorGender;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: AppStrings.formGender,
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.wc),
                    ),
                  ),
                  items: [
                    DropdownMenuItem<String>(
                      value: 'Macho',
                      child: Text('Macho'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Hembra',
                      child: Text('Hembra'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _genderController.text = value!;
                    });
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _openMapScreen(context);
                  },
                  child: Text(AppStrings.formLocation),
                ),
                SizedBox(height: 5),
                FutureBuilder<String>(
                  future: _currentCenterPosition != null
                      ? getAddressFromCoordinates(_currentCenterPosition!.latitude, _currentCenterPosition!.longitude)
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
                          labelText: _currentCenterPosition != null
                              ? AppStrings.formLocationSelected
                              : AppStrings.formEmptyLocationSelected,
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
                          labelText: AppStrings.formEmptyLocationSelected,
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
                SizedBox(height: 16),
                TextFormField(
                  controller: _additionalCommentController,
                  decoration: InputDecoration(
                    labelText: AppStrings.formDescription,
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.comment),
                    ),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _getImage,
                  child: Text(AppStrings.formPhoto),
                ),
                SizedBox(height: 16),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Center(
                      child: _imageFile != null
                          ? Image.file(
                              _imageFile!,
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
              ],
            ),
          ),
        ),
      ),
    );
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
                  _currentCenterPosition = position.target;
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
              if (_currentCenterPosition != null) {
                _saveLocation(_currentCenterPosition!);
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
      _currentCenterPosition = location;
      Navigator.pop(context);
    });
  }

  void _savePost() async {
    if (_imageFile == null) {
      CustomMaterialDialog.successOrError(
        context: context,
        type: DialogType.error,
        title: AppStrings.textErrorTitle,
        message: 'Por favor selecciona una foto',
      );
      return;
    }

    if (!_formKey.currentState!.validate()) {
      CustomMaterialDialog.successOrError(
        context: context,
        type: DialogType.error,
        title: AppStrings.textErrorTitle,
        message: AppStrings.textErrorMessage,
      );
      return;
    }

    double longitude = _currentCenterPosition!.longitude;
    double latitude = _currentCenterPosition!.latitude;

    GeoJson geoJsonLocation = GeoJson(
      x: 2,
      y: 3,
      type: 'Point',
      coordinates: [longitude, latitude],
    );

    SavePost savePostInstance = SavePost(
      title: _titleController.text,
      additionalComment: _additionalCommentController.text,
      typePost: typePost.name,
      author: author,
      date: _selectedDate ?? DateTime.now(),
      animal: Animal(
        name: _nameController.text,
        type: _typeController.text,
        race: _raceController.text,
        gender: _genderController.text,
      ),
      location: geoJsonLocation,
      state: statePost.name,
    );

    SavePost savePost =
        await api.savePost(savePostInstance, _imageFile!, context);

    print('Publicacion guardada ${savePost.id}');
  }

  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
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

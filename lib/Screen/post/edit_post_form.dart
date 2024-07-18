import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:familylost_faan/ServiciosApp/dto/animal.dart';
import 'package:familylost_faan/ServiciosApp/dto/author.dart';
import 'package:familylost_faan/ServiciosApp/dto/geo_json.dart';
import 'package:familylost_faan/ServiciosApp/utils/animal_list.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/ServiciosApp/services/post_service.dart';
import 'package:familylost_faan/pages/pages.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/utilities/fonts/app_fonts.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditPostFormPage extends StatefulWidget {
  final SavePost post;
  const EditPostFormPage({super.key, required this.post});

  @override
  State<EditPostFormPage> createState() => _EditPostFormPageState();
}

class _EditPostFormPageState extends State<EditPostFormPage> {
  final api = PostService();
  bool showOtherBreedTextField = false;

  Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentCenterPosition;
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  final _titleController = TextEditingController();
  DateTime? _selectedDate;
  final _additionalCommentController = TextEditingController();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _raceController = TextEditingController();
  final _genderController = TextEditingController();
  late String postImage;
  final _imagePicker = ImagePicker();
  late File? _selectedImage = null;
  late String postType;
  late String postState;
  late String postId;
  late Author author;

  @override
  void initState() {
    super.initState();
    print(widget.post.typePost);
    _setData();
  }

  void _setData() {
    _titleController.text = widget.post.title;
    _selectedDate = widget.post.date;
    _nameController.text = widget.post.animal.name;
    _typeController.text = widget.post.animal.type;
    _raceController.text = widget.post.animal.race;
    _genderController.text = widget.post.animal.gender;
    _additionalCommentController.text = widget.post.additionalComment ?? '';
    _currentCenterPosition = LatLng(
      widget.post.location.coordinates[1],
      widget.post.location.coordinates[0],
    );
    postImage = widget.post.imageUrl;
    postType = widget.post.typePost;
    postState = widget.post.state;
    postId = widget.post.id!;
    author = widget.post.author;
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
          AppStrings.formEdit,
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
              _editPost();
            },
            child: Text(
              AppStrings.buttonEdit,
              style: TextStyle(
                color: AppColors.icnColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: _updateFormData(context),
    );
  }

  Form _updateFormData(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;
    return Form(
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
                  SizedBox(width: 30),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        TextFormField(
                          style: AppFonts.InputTitlePost,
                          textCapitalization: TextCapitalization.words,
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
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: _currentCenterPosition != null
                      ? 'Lat: ${_currentCenterPosition!.latitude.toStringAsFixed(6)}, Lng: ${_currentCenterPosition!.longitude.toStringAsFixed(6)}'
                      : '',
                ),
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
                onPressed: _imageChooser,
                child: Text(AppStrings.formPhoto),
              ),
              SizedBox(height: 16),
              Container(
                height: _deviceSize.width * 0.6,
                width: double.infinity,
                child: Center(
                  child: IconButton(
                    onPressed: _imageChooser,
                    icon: CircleAvatar(
                      radius: _deviceSize.width * 0.8,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : postImage.isNotEmpty
                              ? CachedNetworkImageProvider(postImage)
                              : AssetImage(AssetManager.largeLogo)
                                  as ImageProvider<Object>?,
                    ),
                    iconSize: _deviceSize.width * 0.6,
                  ),
                ),
              ),
            ],
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
    setState(() {
      _currentCenterPosition = location;
      Navigator.pop(context);
    });
  }

  void _editPost() async {
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
      id: postId,
      title: _titleController.text,
      additionalComment: _additionalCommentController.text,
      typePost: postType, //Check is needed here
      author: author,
      animal: Animal(
        name: _nameController.text,
        type: _typeController.text,
        race: _raceController.text,
        gender: _genderController.text,
      ),
      location: geoJsonLocation,
      state: postState, //Check is needed here
    );

    await api.updatePost(savePostInstance, context);
    _updateImagePost();
  }

  void _updateImagePost() async {
    if (_selectedImage != null) {
      await api.updateImagePost(
        postId,
        _selectedImage!,
        context,
      );

      Navigator.pop(context);
      
    }
  }
}

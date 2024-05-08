import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';

class RegistroAnimalPerdidoScreen extends StatefulWidget {
  @override
  _RegistroAnimalPerdidoScreenState createState() =>
      _RegistroAnimalPerdidoScreenState();
}

class _RegistroAnimalPerdidoScreenState
    extends State<RegistroAnimalPerdidoScreen> {
  File? _imageFile;
  final picker = ImagePicker();
  String? _selectedSexo;
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _razaController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _ubicacionController = TextEditingController();

  List<String> _sexos = ['Macho', 'Hembra'];

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

  @override
  void initState() {
    super.initState();
    _nombreController.text = 'Nombre del animal';
    _razaController.text = 'Raza';
    _descripcionController.text = 'Descripción';
    _ubicacionController.text = 'Ubicación';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Publicar animal Perdido',
          style: GoogleFonts.poppins(
            fontSize: 17.0,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            _buildFieldWithHeader('Añade una foto'),
            Container(
              height: 100,
              color: Colors.grey[200],
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
            ElevatedButton(
              onPressed: _getImage,
              child: Text(
                'Seleccionar foto',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 8),
            _buildFieldWithHeader('Nombre del animal'),
            _buildTextField(_nombreController, 'Ej. Firulais'),
            SizedBox(height: 10),
            _buildFieldWithHeader('Fecha en la que se perdió'),
            _buildDateField(),
            SizedBox(height: 10),
            _buildFieldWithHeader('Sexo'),
            _buildSexoField(),
            SizedBox(height: 10),
            _buildFieldWithHeader('Raza'),
            _buildTextField(_razaController, 'Ej. Labrador'),
            SizedBox(height: 10),
            _buildFieldWithHeader('Descripción'),
            _buildTextField(
                _descripcionController, 'Ej. Color marrón, ojos azules'),
            SizedBox(height: 10),
            _buildFieldWithHeader('Ubicación'),
            _buildTextField(_ubicacionController, 'Ej. Calle 123, Ciudad'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Lógica para guardar el formulario
              },
              child: Text(
                'Guardar',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldWithHeader(String labelText) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: AppColors.mainColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                labelText,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
        style: GoogleFonts.poppins(
          fontSize: 11.0,
          fontWeight: FontWeight.w300,
        ),
        onChanged: (value) {
          if (controller.text.isNotEmpty &&
              controller.text.toLowerCase() == hintText.toLowerCase()) {
            setState(() {
              controller.text = '';
            });
          }
        },
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Ej. 01/01/2022',
          border: OutlineInputBorder(),
        ),
        style: GoogleFonts.poppins(
          fontSize: 14.0,
          fontWeight: FontWeight.w300,
        ),
        onTap: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            // Lógica para manejar la fecha seleccionada
          }
        },
      ),
    );
  }

  Widget _buildSexoField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        value: _selectedSexo,
        items: _sexos.map((String sexo) {
          return DropdownMenuItem<String>(
            value: sexo,
            child: Text(
              sexo,
              style: GoogleFonts.poppins(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedSexo = value;
          });
        },
      ),
    );
  }
}

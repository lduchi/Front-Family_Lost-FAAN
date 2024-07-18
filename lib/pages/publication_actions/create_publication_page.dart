import 'package:flutter/material.dart';

class CreatePublicationPage extends StatefulWidget {
  const CreatePublicationPage({super.key});

  @override
  State<CreatePublicationPage> createState() => _CreatePublicationPageState();
}

class _CreatePublicationPageState extends State<CreatePublicationPage> {
  final _formKey = GlobalKey<FormState>();
  final _animalNameController = TextEditingController();
  final _animalAddressController = TextEditingController();
  String? _selectedBreed;
  String? _selectedGender;
  String? _selectedType;
  int? _animalAge;
  String _animalDescription = '';
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicar Animal Adopción'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _animalNameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre Animal:',
                  ),
                ),
                TextFormField(
                  controller: _animalAddressController,
                  decoration: InputDecoration(
                    labelText: 'Dirección:',
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedBreed,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedBreed = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Raza',
                  ),
                  items: <String>['Raza', 'Otra raza 1', 'Otra raza 2']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Sexo',
                  ),
                  items: <String>['Macho', 'Hembra']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Tipo',
                  ),
                  items: <String>['Canino', 'Felino', 'Otro']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _animalAge = int.tryParse(value);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Edad:',
                  ),
                ),
                TextFormField(
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      _animalDescription = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Descripción:',
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: _imagePath != null
                      ? Image.asset(
                          _imagePath!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.image,
                          size: 100,
                          color: Colors.grey,
                        ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Acción para cancelar
                      },
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Acción para guardar
                      },
                      child: Text('Guardar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

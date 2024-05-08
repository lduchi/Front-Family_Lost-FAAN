import 'package:flutter/material.dart';
import '../Utils/colors.dart';
import 'package:familylost_faan/utilities/fonts/app_fonts.dart';

class EditPost extends StatelessWidget {
 EditPost({super.key});

  TextEditingController scottvalueoneController = TextEditingController();
@override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              backgroundColor1,
              backgroundColor2,
              backgroundColor4,
            ],
            
          ),
        ),
        
        child: SafeArea(
          
          child: ListView(
            children: [

              // Centered App Icon
              Center(
               child: Text(
                        "Editar detalle de publicacion",
                        textAlign: TextAlign.start,
                        style: AppFonts.caption.copyWith(
                          fontSize: 20.5,
                          color: textColor1,
                        ),
                      ),
              ),

              SizedBox(height: size.height * 0.05), // Spacing

              // User Input TextFields (Middle 1/3)
         Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue[100], // Color celeste para el fondo del marco
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFieldWithLabel("Nombre", "Nombre", size),
                SizedBox(height: size.height * 0.01),
                _buildTextFieldWithLabel("Ubicacion", "Ubicacion", size),
              ],
            ),
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue[100], // Color celeste para el fondo del marco
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFieldWithLabel("Fecha", "Fecha", size),
                SizedBox(height: size.height * 0.01),
                _buildTextFieldWithLabel("Tipo de publicacion", "Tipo de publicacion", size),
              ],
            ),
          ),
        ),
      ],
    ),
    SizedBox(height: size.height * 0.01),
    Center( // Centrar la parte de descripcion e imagen
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blue[100], // Color celeste para el fondo del marco
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextFieldWithLabel2("Descripcion", "Descripcion", size),
            SizedBox(height: size.height * 0.01),
            Text(
              "Imagen",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            // Aquí es donde colocaremos la imagen en lugar de un campo de texto
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFFC0C0C0),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),



              
               SizedBox(height: size.height * 0.05), // Spacing

              Container(
  
  height: 50, // Alto personalizado del botón
  width: 10, // Ancho personalizado del botón
  child: ElevatedButton(
    onPressed: () {
      // Implementar la lógica para validar y guardar todo
    },
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.zero, // Eliminar el relleno interno del botón
      backgroundColor: Color.fromARGB(255, 61, 192, 76),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Radio de borde personalizado
      ),
    ),
    child: Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0), // Radio de borde personalizado
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          "Guardar",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  ),
),
              SizedBox(height: size.height * 0.07), // Spacing
              
            ],
            
          ),
          
        ),
        
      ),
      
    );
    
  }

  Widget _buildTitle(String title) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5.0),
    decoration: BoxDecoration(
      color: Colors.blue[100], // Color celeste
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0), // Semicírculo izquierdo
        bottomLeft: Radius.circular(10.0), // Semicírculo izquierdo
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _buildTextFieldWithLabel(String hint, String label, Size size) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        width: 150,
        height: 52.04,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xFFC0C0C0),
          ),
        ),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 124, 120, 120),
              fontSize: 15,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}

Widget _buildTextFieldWithLabel2(String hint, String label, Size size) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        width: 350,
        height: 100.04,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xFFC0C0C0),
          ),
        ),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 124, 120, 120),
              fontSize: 15,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}
}

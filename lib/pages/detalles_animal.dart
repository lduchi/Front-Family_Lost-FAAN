import 'package:familylost_faan/pages/cubit/HeardBorder.dart';
import 'package:flutter/material.dart';

class DetallesAnimal extends StatelessWidget {
  final String image;
  //final VoidCallback onHeartTap;

  const DetallesAnimal({super.key, required this.image});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009AB0),
        title: Text('Detalle Animal'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image),
            SizedBox(height: 16),
            Text(
              ' Gato Sonriente',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            /// boton corazon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeartButton(
                  onPressed: () {
                    // Acción del botón de corazón
                  },
                ),
                Text(
                  '20/12/2024',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 100, 99, 99),
                  ),
                ),
              ],
            ),
            //Ubicacion

            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Color.fromARGB(255, 100, 99, 99),
                ),
                SizedBox(width: 8),
                Text(
                  'Ubicacion',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 100, 99, 99),
                  ),
                ),
              ],
            ),

            SizedBox(height: 50),
            Text(
              'Descripcion:',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            Text(
              'Este animalito es un gato muy juguetón y cariñoso. Le encanta jugar con pelotas y recibir mimos. Es perfecto para hogares con niños y otros animales. Está buscando un hogar amoroso donde pueda ser parte de la familia. ¡No pierdas la oportunidad de adoptarlo!',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 100, 99, 99),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 400,
              child: ElevatedButton(
                onPressed: () {
                  // Logica para el boton de estado
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF009AB0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  "ESTADO",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Otros widgets para mostrar los detalles del animal
          ],
        ),
      ),
    );
  }
}

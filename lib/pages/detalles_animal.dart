import 'package:familylost_faan/ServiciosApp/dto/animal.dart';
import 'package:familylost_faan/ServiciosApp/dto/author.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/pages/cubit/HeardBorder.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetallesAnimal extends StatelessWidget {
  final String image;
  final Animal animalData;
  final Author author;
  final SavePost post;

  //final VoidCallback onHeartTap;

  const DetallesAnimal({
    super.key,
    required this.image,
    required this.animalData,
    required this.author,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009AB0),
        title: Text('Detalle Animal'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(image,
                    height: MediaQuery.of(context).size.height * 0.45),
              ),
              SizedBox(height: 16),
              Text(
                animalData.name,
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
                    '${post.date?.day}/${post.date?.month}/${post.date?.year}',
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
                'Descripción:',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Text(
                post.additionalComment ??
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
                  onPressed: () async {
                    await launchUrl(
                      Uri.parse(
                        "https://wa.me/${author.phone}?text=Hola yo vi a ${animalData.name}",
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF009AB0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    "CONTACTAR",
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
      ),
    );
  }
}

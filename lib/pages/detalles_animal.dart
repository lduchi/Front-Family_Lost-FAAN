import 'package:familylost_faan/ServiciosApp/dto/animal.dart';
import 'package:familylost_faan/ServiciosApp/dto/author.dart';
import 'package:familylost_faan/ServiciosApp/dto/geo_json.dart';
import 'package:familylost_faan/ServiciosApp/dto/save_post.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/services/home_service.dart';
import 'package:familylost_faan/pages/cubit/HeardBorder.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ServiciosApp/services/post_service.dart';

class DetallesAnimal extends StatefulWidget {
  final String image;
  final Animal animalData;
  final Author author;
  final SavePost post;
  final HomePageProvider provider;

  //final VoidCallback onHeartTap;

  const DetallesAnimal({
    super.key,
    required this.image,
    required this.animalData,
    required this.author,
    required this.post,
    required this.provider,
  });

  @override
  State<DetallesAnimal> createState() => _DetallesAnimalState();
}

class _DetallesAnimalState extends State<DetallesAnimal> {
  Marker? _userMarker;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();

    Store.hasAdminRole().then((value) => setState(() {
          isAdmin = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009AB0),
        title: Text(widget.post.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: isAdmin
            ? [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await PostService().deletePost(widget.post.id!, context);
                    setState(() {});
                    await widget.provider.getPostsByType('LOST');
                  },
                ),
              ]
            : [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(widget.image,
                    height: MediaQuery.of(context).size.height * 0.45),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.animalData.name,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.post.typePost,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
                  Column(
                    children: [
                      Text(
                        'Creado por: ${widget.author.username}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 100, 99, 99),
                        ),
                      ),
                      Text(
                        'Fecha de extravío: ${widget.post.date?.day}/${widget.post.date?.month}/${widget.post.date?.year}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 100, 99, 99),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Descripción:',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Text(
                widget.post.additionalComment ??
                    'Este animalito es un gato muy juguetón y cariñoso. Le encanta jugar con pelotas y recibir mimos. Es perfecto para hogares con niños y otros animales. Está buscando un hogar amoroso donde pueda ser parte de la familia. ¡No pierdas la oportunidad de adoptarlo!',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 100, 99, 99),
                ),
                textAlign: TextAlign.justify,
              ),
              //Ubicacion
              const SizedBox(height: 20),
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
                      fontSize: 18,
                      color: Color.fromARGB(255, 100, 99, 99),
                    ),
                  ),
                ],
              ),
              ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: _deviceSize.height * 0.3),
                child: _buildMap(widget.post.location),
              ),

              SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 400,
                child: ElevatedButton(
                  onPressed: () async {
                    await launchUrl(
                      Uri.parse(
                        "https://wa.me/${widget.author.phone}?text=Hola yo vi a ${widget.animalData.name}",
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
          title: 'Pet Location',
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
}

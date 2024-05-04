import 'package:flutter/material.dart';
import '../Screen/app_navigation_screen.dart';
import '../Screen/edicion_detall_publicacion_screen.dart';
import '../Screen/publicaci_n_animal_encontrado_screen.dart';
import '../Screen/publicaci_n_animal_perdido_screen.dart';
import '../Screen/seleccionar_tipo_de_publicaci_n_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String edicionDetallPublicacionScreen =
      '/edicion_detall_publicacion_screen';

  static const String seleccionarTipoDePublicaciNScreen =
      '/seleccionar_tipo_de_publicaci_n_screen';

  static const String publicaciNAnimalEncontradoScreen =
      '/publicaci_n_animal_encontrado_screen';

  static const String publicaciNAnimalPerdidoScreen =
      '/publicaci_n_animal_perdido_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    edicionDetallPublicacionScreen: (context) =>
        EdicionDetallPublicacionScreen(),
    seleccionarTipoDePublicaciNScreen: (context) =>
        SeleccionarTipoDePublicaciNScreen(),
    publicaciNAnimalEncontradoScreen: (context) =>
        PublicaciNAnimalEncontradoScreen(),
    publicaciNAnimalPerdidoScreen: (context) => PublicaciNAnimalPerdidoScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    initialRoute: (context) => SeleccionarTipoDePublicaciNScreen()
  };
}

import 'package:familylost_faan/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:familylost_faan/utilities/colors/app_colors.dart';
import 'package:familylost_faan/utilities/fonts/app_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SeleccionarTipoPopup extends StatefulWidget {
  @override
  _SeleccionarTipoPopupState createState() => _SeleccionarTipoPopupState();
}

class _SeleccionarTipoPopupState extends State<SeleccionarTipoPopup> {
  String _tipoSeleccionado = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Center(
            child: Text(
              '¡Seleccione un tipo!',
              style: AppFonts.successTitle.copyWith(
                fontWeight: FontWeight.bold,
                color: general,
              ),
            ),
          ),
          SizedBox(height: 12), // Espacio entre el título y el subtítulo
          Center(
            child: Text(
              'Selecciona el tipo de publicación a crear',
              style: AppFonts.primary.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center, // Centrar las opciones
        children: <Widget>[
          SizedBox(height: 6), // espacio entre el título y las opciones
          ListTile(
            title: const Text(
              'Perdido',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: general2,
              ),
            ),
            leading: Radio(
              value: 'Perdido',
              groupValue: _tipoSeleccionado,
              onChanged: (value) {
                setState(() {
                  _tipoSeleccionado = value!;
                });
              },
            ),
            onTap: () {
              setState(() {
                _tipoSeleccionado = 'Perdido';
              });
            },
          ),
          ListTile(
            title: const Text(
              'Encontrado',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: general2,
              ),
            ),
            leading: Radio(
              value: 'Encontrado',
              groupValue: _tipoSeleccionado,
              onChanged: (value) {
                setState(() {
                  _tipoSeleccionado = value!;
                });
              },
            ),
            onTap: () {
              setState(() {
                _tipoSeleccionado = 'Encontrado';
              });
            },
          ),
          ListTile(
            title: const Text(
              'Adopción',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: general2,
              ),
            ),
            leading: Radio(
              value: 'Adopción',
              groupValue: _tipoSeleccionado,
              onChanged: (value) {
                setState(() {
                  _tipoSeleccionado = value!;
                });
              },
            ),
            onTap: () {
              setState(() {
                _tipoSeleccionado = 'Adopción';
              });
            },
          ),
          SizedBox(height: 1), // espacio entre las opciones y los botones
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // espacio entre los botones
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3.5),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cancelar
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.red,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.5),
                    child: Text(
                      'Cancelar',
                      style: AppFonts.button.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3.5),
                child: TextButton(
                  onPressed: () {
                    if (_tipoSeleccionado.isNotEmpty) {
                      print('Tipo seleccionado: $_tipoSeleccionado');
                      Navigator.of(context)
                          .pop(); // Cerrar la ventana emergente
                    } else {
                      Fluttertoast.showToast(
                        msg: "¡Seleccione una opción para poder continuar!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: general2,
                        textColor: Colors.white,
                        fontSize: 15.0,
                      );
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.5),
                    child: Text(
                      'Continuar',
                      style: AppFonts.button.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

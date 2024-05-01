import 'package:flutter/material.dart';
import 'package:familylost_faan/profile/Actualizar_profile.dart';
import 'package:familylost_faan/profile/Privacidad_profile.dart';
import 'package:familylost_faan/Screen/sign_in.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart'; // Importa la clase AppFonts

class MenuProfile extends StatelessWidget {
  const MenuProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('images/pet1.png'),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ELIZABETH PEÑAFIEL',
                        style: AppFonts.title.copyWith(
                          color: Color.fromARGB(255, 0, 42, 109),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '+593 96 947 5973',
                        style: AppFonts.caption.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'Profile Settings',
              style: AppFonts.primary.copyWith(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 42, 109),
              ),
            ),
            subtitle: Text(
              'Actualiza y modifica tu perfil',
              style: AppFonts.caption.copyWith(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActualizarProfile()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text(
              'Privacidad',
              style: AppFonts.primary.copyWith(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 42, 109),
              ),
            ),
            subtitle: Text(
              'Cambia tu contraseña',
              style: AppFonts.caption.copyWith(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacidaProfile()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Cerrar Sesión',
              style: AppFonts.primary.copyWith(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 42, 109),
              ),
            ),
            subtitle: Text(
              'Cierra tu sesión de forma segura',
              style: AppFonts.caption.copyWith(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            },
          ),
        ],
      ),
    );
  }
}

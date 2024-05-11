import 'package:familylost_faan/Screen/Sign_In_Up/RegisterPage.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/utilities/icons/app_icons.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:familylost_faan/profile/Actualizar_profile.dart';
import 'package:familylost_faan/profile/Privacidad_profile.dart';
import 'package:familylost_faan/Screen/Sign_In_Up/sign_in.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart'; // Importa la clase AppFonts

class MenuProfile extends StatelessWidget {
  final bool isLogged;

  const MenuProfile({super.key, required bool this.isLogged});

  @override
  Widget build(BuildContext context) {
    return isLogged ? _loggedMenu(context) : _unloggedMenu(context);
  }

  Drawer _unloggedMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Text(
              'Bienvenido',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text(AppStrings.login),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text(AppStrings.buttonRegister),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Acerca de'),
            onTap: () {
              // Navegar a la pantalla de información sobre la app
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Ayuda'),
            onTap: () {
              // Navegar a la pantalla de ayuda
            },
          ),
        ],
      ),
    );
  }

  Drawer _loggedMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.secondaryMainColor,
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
                          color: AppColors.activeBlueColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '+593 96 947 5973',
                        style: AppFonts.primary.copyWith(
                          color: AppColors.secondaryColor,
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
                color: AppColors.activeBlueColor,
              ),
            ),
            subtitle: Text(
              'Actualiza y modifica tu perfil',
              style: AppFonts.caption.copyWith(
                color: AppColors.secondaryColor,
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
                color: AppColors.activeBlueColor,
              ),
            ),
            subtitle: Text(
              'Cambia tu contraseña',
              style: AppFonts.caption.copyWith(
                color: AppColors.secondaryColor,
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
                color: AppColors.activeBlueColor,
              ),
            ),
            subtitle: Text(
              'Cierra tu sesión de forma segura',
              style: AppFonts.caption.copyWith(
                color: AppColors.secondaryColor,
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

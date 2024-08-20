import 'package:cached_network_image/cached_network_image.dart';
import 'package:familylost_faan/Screen/Sign_In_Up/RegisterPage.dart';
import 'package:familylost_faan/ServiciosApp/dto/user_dto.dart';
import 'package:familylost_faan/ServiciosApp/notification/notifications.dart';
import 'package:familylost_faan/ServiciosApp/services/user_service.dart';
import 'package:familylost_faan/ServiciosApp/web_socket/web_socket.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/utilities/enum/dialog_type.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:familylost_faan/widgets/custom_quick_alert.dart';
import 'package:flutter/material.dart';
import 'package:familylost_faan/profile/Actualizar_profile.dart';
import 'package:familylost_faan/profile/Privacidad_profile.dart';
import 'package:familylost_faan/Screen/Sign_In_Up/sign_in.dart';
import 'package:familylost_faan/utilities/Fonts/app_fonts.dart'; // Importa la clase AppFonts

class MenuProfile extends StatefulWidget {
  final bool isLogged;

  const MenuProfile({super.key, required bool this.isLogged});

  @override
  State<MenuProfile> createState() => _MenuProfileState();
}

class _MenuProfileState extends State<MenuProfile> {
  UserDTO? user;
  String? userId;
  @override
  void initState() {
    super.initState();
    _getStoredId().then((value) {
      userId = value;
      _getUser();
    });
  }

  Future<String?> _getStoredId() async {
    userId = await Store.getUserId();
    return userId;
  }

  void _getUser() async {
    user = await UserService().getUserById(userId!, context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLogged ? _loggedMenu(context) : _unloggedMenu(context);
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
    if (user == null) {
      return Drawer();
    }

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
                    backgroundImage: CachedNetworkImageProvider(
                      user!.imageUrl.isNotEmpty
                          ? user!.imageUrl
                          : AssetManager.largeLogo,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user!.name + ' ' + user!.lastname,
                        style: AppFonts.title.copyWith(
                          color: AppColors.activeBlueColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        user!.phone,
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
                MaterialPageRoute(builder: (context) => PrivacidadProfile()),
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
              _logout(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    Store.removeToken();

    cancelScheduledNotification;

    WebSocketChnl.instance.disconnect();

    CustomMaterialDialog.successOrError(
        context: context,
        type: DialogType.success,
        title: '¡Hasta pronto!',
        message: 'Sesión cerrada correctamente');
  }
}

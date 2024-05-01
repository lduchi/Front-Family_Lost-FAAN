import 'package:flutter/material.dart';
import 'package:familylost_faan/profile/Actualizar_profile.dart';
import 'package:familylost_faan/profile/Privacidad_profile.dart';
import 'package:familylost_faan/Screen/sign_in.dart';

class MenuProfile extends StatelessWidget {
  const MenuProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Container(
            height: 200,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('images/pet1.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ELIZABETH PEÑAFIEL',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '+593 96 947 5973',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Profile Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActualizarProfile()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacidad'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacidaProfile()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
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

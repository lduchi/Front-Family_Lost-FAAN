import 'package:familylost_faan/profile/Actualizar_profile.dart';
import 'package:familylost_faan/profile/Privacidad_profile.dart';
import 'package:flutter/material.dart';
import 'package:familylost_faan/Screen/sign_in.dart';

class MenuProfile extends StatelessWidget {
  const MenuProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('images/persona.jpg'),
              ),
            ),
            Text(
              'ELIZABETH PEÑAFIEL',
              style:
                  TextStyle(fontSize: 24, color: Color.fromARGB(255, 9, 3, 94)),
            ),
            SizedBox(height: 5),
            Text(
              '+593 96 947 5973',
              style:
                  TextStyle(fontSize: 18, color: Color.fromARGB(255, 9, 3, 94)),
            ),
            SizedBox(height: 50),
            //Boton 1

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActualizarProfile()),
                );
              },
              icon: Icon(
                Icons.edit,
                size: 24.0,
                color: Color.fromARGB(255, 144, 141, 141),
              ),
              label: Text(
                'Profile Settings',
                style: TextStyle(color: Color.fromARGB(255, 25, 12, 203)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(300, 50),
              ),
            ),

            SizedBox(height: 16),
            //Boton 2
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacidaProfile()),
                );
              },
              icon: Icon(
                Icons.privacy_tip,
                size: 24.0,
                color: Color.fromARGB(255, 144, 141, 141),
              ),
              label: Text(
                'Privacidad',
                style: TextStyle(color: Color.fromARGB(255, 25, 12, 203)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(300, 50),
              ),
            ),

            SizedBox(height: 16),
            //Boton 3
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
              icon: Icon(
                Icons.logout,
                size: 24.0,
                color: Color.fromARGB(255, 144, 141, 141),
              ),
              label: Text(
                'Cerrar Sesion',
                style: TextStyle(color: Color.fromARGB(255, 25, 12, 203)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(300, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

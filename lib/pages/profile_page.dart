import 'package:flutter/material.dart';
import 'package:familylost_faan/profile/Menu_profile.dart';
import 'package:familylost_faan/utilities/Colors/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(127, 255, 255, 255),
        foregroundColor: Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      drawer: MenuProfile(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('images/pet1.png'),
                ),
                SizedBox(height: 8),
                Text(
                  'Elizabeth Penafiel',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'elizabethpeñafiel@gmail.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 101, 98, 98),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Implementar acción para 'Publicaciones'
                      },
                      child: Text(
                        'Publicaciones',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 82, 82, 82),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Implementar acción para 'Otro'
                      },
                      child: Text(
                        'Otro',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 82, 82, 82),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

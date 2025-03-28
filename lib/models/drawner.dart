import 'package:flutter/material.dart';
import '../views/aPropos.dart';
import '../views/contact.dart';
import '../main.dart';


class Drawner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),//redirection vers la pageprincipal
                );
              },
            ),
            ListTile(
              title: Text('À Propos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => APropos()),//redirection vers la page "À Propos"
                );
              },  
            ),
            ListTile(
              title: Text('Contact'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Contact()),//redirection vers la page "Contact"
                );
              },  
            ),
          ],
        ),      
    );
  }
}
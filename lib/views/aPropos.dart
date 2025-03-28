import 'package:flutter/material.dart';
import '../models/drawner.dart';


class APropos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawner(),
      appBar: AppBar(
        title: Text('À Propos'),
      ),
       body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrage verticale
          children: <Widget> [
            Text(
              'À Propos',
              style: TextStyle(
                fontSize: 18,//tail du text 
                fontWeight: FontWeight.bold //style du text
              ),
            ),
            SizedBox(height: 20), // Espacement
            Img(), // Ajout de l'image
            Padding(
              padding: const EdgeInsets.only(left: 300, right: 300, top: 15, bottom: 0),
              child:Text(
                "Flutter est un kit de développement logiciel d interface utilisateur open-source créé par Google."+
                "Il est utilisé pour développer des applications pour Android,"+
                "iOS, Linux, Mac, Windows, Google Fuchsia et le web à partir d une seule base de code.",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center, //disposition du text
              )
            )
          ],
        ),
      )
    );
  }
}


class Img extends StatelessWidget {
  const Img({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('../assets/images/interet-world-wide-web.jpg'),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../models/drawner.dart';

class APropos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawner(),
      appBar: AppBar(
        title: const Text('À Propos'),
      ),
      body: SingleChildScrollView( // ✅ Scroll activé
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrage vertical
          children: <Widget>[
            const SizedBox(height: 20), // Espacement initial
            const Text(
              'À Propos',
              style: TextStyle(
                fontSize: 18, // Taille du texte
                fontWeight: FontWeight.bold, // Style gras
              ),
            ),
            const SizedBox(height: 20), // Espacement
            const Img(), // Ajout de l'image
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                "Flutter est un kit de développement logiciel d'interface utilisateur open-source créé par Google. "
                "Il est utilisé pour développer des applications pour Android, "
                "iOS, Linux, Mac, Windows, Google Fuchsia et le web à partir d'une seule base de code.",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center, // Alignement du texte
              ),
            ),
            const SizedBox(height: 40), // Espacement bas
          ],
        ),
      ),
    );
  }
}

// Image circulaire
class Img extends StatelessWidget {
  const Img({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/interet-world-wide-web.jpg'), // ✅ Chemin corrigé
        ),
      ),
    );
  }
}

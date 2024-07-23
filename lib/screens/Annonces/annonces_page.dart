import 'package:flutter/material.dart';
import 'package:gandalverse/screens/Annonces/components/annonceCard.dart';

import 'components/detailsAnnonceAlert.dart';

class AnnoncesPage extends StatefulWidget {
  const AnnoncesPage({super.key});

  @override
  State<AnnoncesPage> createState() => _AnnoncesPageState();
}

class _AnnoncesPageState extends State<AnnoncesPage> {
  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        minimum: const EdgeInsets.all(5.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Récompense",
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15,
                    color: Color3,
                    fontFamily: "Aller",
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          AnnonceCard(
              title: 'Votre récompense quotidienne',
              text: '---',
              icon: Icons.info_outline_rounded,
              backColors: const [
                Colors.white,
                Colors.white,
              ],
              press: () {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) => AnnonceDetailsAlert(),
                );
              },
              textColor: Colors.black,
              titleColor: Color3),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tâches",
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15,
                    color: Color3,
                    fontFamily: "Aller",
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          AnnonceCard(
              title: 'Tâche du jour',
              text: '---',
              icon: Icons.info_outline_rounded,
              backColors: const [
                Colors.white,
                Colors.white,
              ],
              press: () {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) => AnnonceDetailsAlert(),
                );
              },
              textColor: Colors.black,
              titleColor: Color3),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Annonces",
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15,
                    color: Color3,
                    fontFamily: "Aller",
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          AnnonceCard(
              title: 'Titre de l\'annonce',
              text: 'Description ou information sur l\'annonce',
              icon: Icons.info_outline_rounded,
              backColors: const [
                Colors.white,
                Colors.white,
              ],
              press: () {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) => AnnonceDetailsAlert(),
                );
              },
              textColor: Colors.black,
              titleColor: Color3),
          AnnonceCard(
              title: 'Titre de l\'annonce',
              text: 'Description ou information sur l\'annonce',
              icon: Icons.info_outline_rounded,
              backColors: const [
                Colors.white,
                Colors.white,
              ],
              press: () {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) => AnnonceDetailsAlert(),
                );
              },
              textColor: Colors.black,
              titleColor: Color3),
          AnnonceCard(
              title: 'Titre de l\'annonce',
              text: 'Description ou information sur l\'annonce',
              icon: Icons.info_outline_rounded,
              backColors: const [
                Colors.white,
                Colors.white,
              ],
              press: () {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) => AnnonceDetailsAlert(),
                );
              },
              textColor: Colors.black,
              titleColor: Color3),
        ]),
      ),
    );
  }
}

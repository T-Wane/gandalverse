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
    return Column(
      children: [
        AnnonceCard(
            title: 'Titre de l\'annonce',
            text: 'Description ou information sur l\'annonce',
            icon: Icons.info_outline_rounded,
            backColors: const [
              Colors.white,
              Colors.white,
            ],
            press: () { showDialog(
              barrierDismissible: true,
              context: context,
              builder: (_) => AnnonceDetailsAlert(),
            );},
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
            press: () {showDialog(
              barrierDismissible: true,
              context: context,
              builder: (_) => AnnonceDetailsAlert(),
            );},
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
            press: () {showDialog(
              barrierDismissible: true,
              context: context,
              builder: (_) => AnnonceDetailsAlert(),
            );},
            textColor: Colors.black,
            titleColor: Color3),
      ],
    );
  }
}

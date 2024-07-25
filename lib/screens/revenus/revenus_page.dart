import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/widgets/customImageView.dart';

import '../../components/user_top_infos.dart';
import '../../themes/images/appImages.dart';
import '../Annonces/components/annonceCard.dart';

class AllRevenusPage extends StatefulWidget {
  const AllRevenusPage({super.key});

  @override
  State<AllRevenusPage> createState() => _AllRevenusPageState();
}

class _AllRevenusPageState extends State<AllRevenusPage> {
  Color Color3 = const Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.all(5.0),
        child: Column(children: [
          const userTopInfos(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CustomImageView(
                    imagePath: "assets/images/coin.png",
                    fit: BoxFit.contain,
                    height: 90,
                    width: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: AutoSizeText(
                    'Gagner comme jamais',
                    maxLines: 1,
                    minFontSize: 20,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 25, color: Color3, fontFamily: "Aller"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: AutoSizeText(
                    'Suivez les revenus générés par la publicité et découvrez comment ils sont redistribués',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Color3.withOpacity(0.7)),
                  ),
                ),
                AnnonceCard(
                    title: 'Publicité',
                    text: 'Profiter d\'une commission jusqu\'à 20%',
                    imagePath: Images.pub,
                    backColors: [
                      Color3.withOpacity(0.2),
                      Color3.withOpacity(0.5),
                      Color3.withOpacity(0.8),
                      Color3,
                    ],
                    fit: BoxFit.contain,
                    press: () {},
                    textColor: Colors.black,
                    titleColor: Color3),
                AnnonceCard(
                    title: 'Panneaux',
                    text:
                        'Voir les panneaux disponibles et ceux qui sont loués avec les revenus générés',
                    imagePath: Images.panneaux,
                    backColors: const [
                      Colors.white,
                      Colors.white,
                    ],
                    fit: BoxFit.contain,
                    press: () {},
                    textColor: Colors.black,
                    titleColor: Color3),
                AnnonceCard(
                    title: 'Redistribution',
                    text:
                        'Suivre comment les revenus sont redistribués aux utilisateurs actifs',
                    imagePath: Images.redistribuer,
                    backColors: const [
                      Colors.white,
                      Colors.white,
                    ],
                    fit: BoxFit.contain,
                    press: () {},
                    textColor: Colors.black,
                    titleColor: Color3),
                AnnonceCard(
                    title: 'AirDrop',
                    text: 'Airdrop du token GVT à venir',
                    imagePath: Images.coin,
                    backColors: const [
                      Colors.white,
                      Colors.white,
                    ],
                    fit: BoxFit.contain,
                    press: () {},
                    textColor: Colors.black,
                    titleColor: Color3),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'infoLigne.dart';

class infosCard extends StatelessWidget {
  infosCard({
    super.key,
  });
  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.only(top: 60, bottom: 5, left: 8, right: 8),
          shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          color: Color3.withOpacity(0.9),
          child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                children: [
                  detailsLigne(
                    titre: "Nom",
                    data: 'Joe Brig',
                    nLigne: 1,
                    maxFontTitre: 13,
                    maxFontData: 15,
                    titreColor: Colors.white,
                    dataColor: Colors.white,
                    setContenu_bold: false,
                    setTitre_bold: false,
                    showData: true,
                  ),
                  detailsLigne(
                    titre: "Email",
                    data: 'joe@gmail.com',
                    nLigne: 1,
                    maxFontTitre: 13,
                    maxFontData: 15,
                    titreColor: Colors.white,
                    dataColor: Colors.white,
                    setContenu_bold: false,
                    setTitre_bold: false,
                    showData: true,
                  ),
                  detailsLigne(
                    titre: "Contact",
                    data: '+223 65567057',
                    nLigne: 1,
                    maxFontTitre: 13,
                    maxFontData: 15,
                    titreColor: Colors.white,
                    dataColor: Colors.white,
                    setContenu_bold: false,
                    setTitre_bold: false,
                    showData: true,
                  ),
                ],
              )),
        ),
        Align(alignment: Alignment.topCenter,
          child: Container(
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black87,
              image: DecorationImage(
                image: AssetImage("assets/images/img_back1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

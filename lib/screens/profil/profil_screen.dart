import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/screens/profil/components/user_icon.dart';

import 'components/info_item.dart';
import 'components/infos_card.dart';

class MonProfilScreen extends StatefulWidget {
  MonProfilScreen({super.key});

  @override
  State<MonProfilScreen> createState() => _MonProfilScreenState();
}

class _MonProfilScreenState extends State<MonProfilScreen> {
  Color Color3 = Color.fromARGB(255, 18, 40, 70);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      const SizedBox(height: 10),

      infosCard(),
      //*********************** */
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Color3.withOpacity(0.9),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: AutoSizeText(
                  "Termes & Politique de confidentialié",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: 'Aller',
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: Icon(
                  CupertinoIcons.shield_lefthalf_fill,
                  color: Color3,
                ),
              ),
            ]),
      ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Color3.withOpacity(0.9),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: AutoSizeText(
                      "Partager GandalVerse",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Aller',
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: Icon(
                      Icons.share,
                      color: Color3,
                    ),
                  ),
                ]),
          ),

      const SizedBox(
        height: 10,
      ),
    ]));
  }
}

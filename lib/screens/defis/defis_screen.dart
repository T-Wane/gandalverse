import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/components/user_top_infos.dart';
import 'package:gandalverse/screens/defis/components/_build_facebook_communauty.dart';
import 'package:gandalverse/screens/defis/components/_build_tiktok_communauty.dart';
import 'package:gandalverse/screens/defis/components/annonceCard.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';

import '../../widgets/customImageView.dart';
import 'components/_build_daily_days.dart';
import 'components/_build_go_words.dart';
import 'components/_build_scanQr_partenaire.dart';
import 'components/_build_telegram_communauty.dart';
import 'components/_build_twitter_communauty.dart';
import 'components/_build_youtube_communauty.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.all(5.0),
        child: Column(children: [
          userTopInfos(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView(
                  padding: const EdgeInsets.only(bottom: 50),
                  children: [
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
                    buildDailyDays(
                      Color3: Color3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Défi du jour",
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
                    buildGoWords(),
                    AnnonceCard(
                        title: 'Enigmes',
                        text: 'Gagner en résolvant l\'énigme du jour',
                        imagePath: Images.question,
                        backColors: const [
                          Colors.white,
                          Colors.white,
                        ],
                        fit: BoxFit.contain,
                        press: () {},
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
                    buildScanQrPartenaire(Color3: Color3),
                    buildTelegramCommunauty(Color3: Color3),
                    buildYoutubeCommunauty(Color3: Color3),
                    buildFacebookCommunauty(
                      Color3: Color3,
                    ),
                    buildTiktokCommunauty(
                      Color3: Color3,
                    ),
                    buildTwitterCommunauty(
                      Color3: Color3,
                    ),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}

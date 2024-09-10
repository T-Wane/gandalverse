import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/components/user_top_infos.dart';
import 'package:gandalverse/core/modeles/social_link/social_link.dart';
import 'package:gandalverse/core/repositories/social_link_repo/social_linkRespository.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/screens/defis/components/_build_communauty_card.dart';
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
          userTopInfos(
            showBackArrow: true,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                  // padding: const EdgeInsets.only(bottom: 50),
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
                    buildScanQrPartenaire(Color3: Color3),
                    // AnnonceCard(
                    //     title: 'Enigmes',
                    //     text: 'Gagner en résolvant l\'énigme du jour',
                    //     imagePath: Images.question,
                    //     backColors: const [
                    //       Colors.white,
                    //       Colors.white,
                    //     ],
                    //     fit: BoxFit.contain,
                    //     press: () {},
                    //     textColor: Colors.black,
                    //     titleColor: Color3),
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
/*
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
                    ),*/

                     FutureBuilder<List<SocialLinkModel>>(
                          future: getIt<SocialLinkService>().getSocialLinks(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Erreur : ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text('Aucune donnée disponible'));
                            } else {
                              List<SocialLinkModel> socialLinkData =
                                  snapshot.data!;
                              return Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(5),
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: socialLinkData.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      SocialLinkModel socialItem =
                                          socialLinkData[index];
                                      return buildCommunautyCard(
                                          socialLinkModel: socialItem);
                                    }),
                              );
                            }
                          }),
                   
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}

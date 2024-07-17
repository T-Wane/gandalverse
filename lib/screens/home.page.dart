import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/screens/Annonces/annonces_page.dart';
import 'package:gandalverse/screens/amis/amis_page.dart';
import 'package:gandalverse/screens/decouvrir/decouvir_page.dart';
import 'package:gandalverse/screens/profil/profil_screen.dart';
import 'package:gandalverse/screens/webPage/webpage.dart';
import 'package:gandalverse/widgets/bottomSheet_modal.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/percent_indicator/linear_percent_indicator.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
//import 'package:telegram_web_app/telegram_web_app.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'components/body.dart';
import 'custom_bubble_navigation_bar/src/custom_navigation_bar_item.dart';
import 'custom_bubble_navigation_bar/src/custome_navigation_bar.dart';
import 'package:gandalverse/widgets/snackBar/sstring_snack_extension.dart';

// import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;
// import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';

import 'package:telegram_web_app/telegram_web_app.dart';

const Color3 = Color.fromARGB(255, 18, 40, 70);

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final TelegramWebApp telegram = TelegramWebApp.instance;

  int _currentIndex = 0;
  static double fontSizeValue = 1.0;
  bool hasBanner = true;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  //##############################################################//
  late final WebViewController controller;
  final TelegramWebApp telegram = TelegramWebApp.instance;

  bool? isDefinedVersion;
  String? clipboardText;

  @override
  void initState() {
    super.initState();
    FlutterError.onError = (details) {
      print("Flutter error happened: $details");
    };

    TelegramWebApp.instance.ready();

    check();
  }

  void check() async {
    await Future.delayed(const Duration(seconds: 2));
    isDefinedVersion = await telegram.isVersionAtLeast('Bot API 6.1');
    setState(() {});
  }

  // @override
  // void initState() {
  //   super.initState();
  //   /*controller = WebViewController()
  //     ..loadRequest(
  //       Uri.parse('https://gandalverse.com'),
  //     );
  //   FlutterError.onError = (details) {
  //     //showSnackbar("Flutter error: $details");
  //     print("Flutter error happened: $details");
  //   };*/

  //   //TelegramWebApp.instance.ready();

  //   //  check();
  // }
/*
  void check() async {
    await Future.delayed(const Duration(seconds: 2));
    isDefinedVersion = await telegram.isVersionAtLeast('Bot API 6.1');
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final scale = mediaQueryData.textScaleFactor;
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        key: _key,
        extendBody: true,
        // backgroundColor: telegram.backgroundColor,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 1.2,
                borderOnForeground: true,
                surfaceTintColor: Color3.withOpacity(0.9),
                color: Color3.withOpacity(0.9),
                shadowColor:
                    const Color.fromARGB(255, 151, 116, 211).withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: Colors.purple.shade100,
                          ),
                        ),
                        margin: const EdgeInsets.only(left: 5, right: 2),
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          CupertinoIcons.person,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "User Name",
                                //   "${telegram.initData.user.username ?? ''} ${telegram.initData.user.lastname ?? ''}",
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontFamily: "Aller",
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            SizedBox(
                              width: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "GV Junior >",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.purple.shade100,
                                          fontFamily: "Aller",
                                          fontSize: 10),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  LinearPercentIndicator(
                                    percent: 0.5,
                                    backgroundColor:
                                        Colors.grey.shade200.withOpacity(0.2),
                                    progressColor: Colors.deepPurple.shade400,
                                    lineHeight: 5.0,
                                    barRadius: const Radius.circular(10),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 20,
                          ),
                          const Row(
                            children: [
                              Text(
                                "Profit par heure",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white70,
                                    fontFamily: "Aller",
                                    fontSize: 8),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                CupertinoIcons.info_circle_fill,
                                color: Colors.white60,
                                size: 15,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomImageView(
                                imagePath: "assets/images/coin.png",
                                fit: BoxFit.contain,
                                height: 25,
                                width: 25,
                              ),
                              const Text(
                                "200K",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white70,
                                    fontFamily: "Aller",
                                    fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            /*Center(
              child:  GandalVerseWebView(controller: controller),
            ),*/
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: _buildFloatingBarCustom(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingBarCustom() {
    return CustomNavigationBar(
      iconSize: 22.0,
      selectedColor: Colors.white,
      strokeColor: const Color(0x300c18fb),
      unSelectedColor: Colors.grey.shade100,
      backgroundColor: Color3.withOpacity(0.9),
      borderRadius: const Radius.circular(10.0),
      items: [
        CustomNavigationBarItem(
          isMain: true,
          icon: const Icon(
            CupertinoIcons.hexagon,
          ),
          title: const Text(
            "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Aller",
              fontWeight: FontWeight.w200,
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(
            Icons.auto_fix_high,
          ),
          title: const Text(
            "Découvrir",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Aller",
              fontSize: 12,
              fontWeight: FontWeight.w200,
              color: Colors.white70,
            ),
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(
            CupertinoIcons.person_2_fill,
          ),
          title: const Text(
            "Amis",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Aller",
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Colors.white70,
            ),
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(
            Icons.newspaper_rounded,
          ),
          title: const Text(
            "Annonces",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Aller",
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Colors.white70,
            ),
          ),
        ),
        CustomNavigationBarItem(
          icon: CustomImageView(
            imagePath: "assets/images/coin.png",
            fit: BoxFit.contain,
          ),
          title: const Text(
            "AirDrops",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Aller",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
            ),
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (int index) {
        switch (index) {
          case 1:
            CustomBottomModalSheet.show(context,
                child: DecouvrirPage(), titre: 'Décourir ');
            break;
          case 2:
            CustomBottomModalSheet.show(context,
                child: AmisPage(), titre: 'Mes Amis');
            break;
          case 3:
            CustomBottomModalSheet.show(context,
                child: AnnoncesPage(), titre: 'Nos Annonces');
            break;
          case 4:
            CustomBottomModalSheet.show(context,
                child: MonProfilScreen(), titre: 'Profil ');
            break;
        }
      },
      isFloating: true,
    );
  }

  Widget _selectedMenu() => Padding(
        padding: const EdgeInsets.only(left: 2, right: 5),
        child: PopupMenuButton<int>(
          icon: const Icon(
            CupertinoIcons.ellipsis_vertical,
            color: Colors.white,
            size: 20,
          ),

          itemBuilder: (context) => [
            PopupMenuItem(
                value: 1,
                child: _actionList(CupertinoIcons.refresh, "Rafraîchir")),
            PopupMenuItem(
                value: 2,
                child: _actionList(CupertinoIcons.shield_lefthalf_fill,
                    "Politique de confidentialité")),
            PopupMenuItem(
                value: 3, child: _actionList(CupertinoIcons.power, "Quitter")),
          ],
          offset: const Offset(0, 40),
          color: Color.fromARGB(255, 18, 54, 96),
          elevation: 2,
          // on selected we show the dialog box
          onSelected: (value) {
            if (value == 1) {
              controller.reload();
            } else if (value == 2) {
            } else if (value == 3) {}
          },
        ),
      );

// custom action widget
  Widget _actionList(IconData icon, String text) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          maxLines: 1,
          textAlign: TextAlign.right,
          style: const TextStyle(
              fontSize: 15, fontFamily: 'Aller', color: Colors.white),
        )
      ],
    );
  }
}

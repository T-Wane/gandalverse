import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/screens/Annonces/annonces_page.dart';
import 'package:gandalverse/screens/amis/amis_page.dart';
import 'package:gandalverse/screens/decouvrir/decouvir_page.dart';
import 'package:gandalverse/screens/profil/profil_screen.dart';
import 'package:gandalverse/screens/revenus/revenus_page.dart';
import 'package:gandalverse/screens/webPage/webpage.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_modal.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/percent_indicator/linear_percent_indicator.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
//import 'package:telegram_web_app/telegram_web_app.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import '../components/user_top_infos.dart';
import 'components/body.dart';
import 'custom_bubble_navigation_bar/src/custom_navigation_bar_item.dart';
import 'custom_bubble_navigation_bar/src/custome_navigation_bar.dart';
import 'package:gandalverse/widgets/snackBar/sstring_snack_extension.dart';

// import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;
// import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';

import 'package:telegram_web_app/telegram_web_app.dart';

import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

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
  late final PlatformWebViewController controller;
  final TelegramWebApp telegram = TelegramWebApp.instance;

  bool? isDefinedVersion;
  String? clipboardText;

  @override
  void initState() {
    super.initState();
    controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadRequest(
        LoadRequestParams(
          uri: Uri.parse('https://gandalverse.com'),
        ),
      );

    FlutterError.onError = (details) {
      //showSnackbar("Flutter error: $details");
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
        backgroundColor: Colors.white,
        // backgroundColor: telegram.backgroundColor,
        body: Stack(children: [
          IndexedStack(index: _currentIndex, children: [
            GandalVerseWebView(controller: controller),
            const DecouvrirPage(),
            const AmisPage(),
            const AnnoncesPage(),
            const AllRevenusPage(),
          ]),
        ]),
        bottomNavigationBar: _buildFloatingBarCustom(),
      ),
    );
  }

  Widget _buildFloatingBarCustom() {
    return CustomNavigationBar(
      iconSize: 22.0,
      selectedColor: Colors.purple.shade400,
      strokeColor: const Color(0x300c18fb),
      unSelectedColor: Colors.grey.shade200,
      backgroundColor: Color3,
      borderRadius: Radius.circular(_currentIndex == 0 ? 1 : 10.0),
      items: [
        CustomNavigationBarItem(
          isMain: true,
          icon: CustomImageView(
            imagePath: Images.vr,
            fit: BoxFit.contain,
            height: double.infinity,
            width: double.infinity,
          ),
          // const Icon(
          //   CupertinoIcons.hexagon,
          // ),
          title: Text(
            "",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Aller",
                fontWeight: getFontSize(0),
                fontSize: 12,
                color: getColor(0)),
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(
            Icons.business_rounded,
          ),
          title: Text(
            "Bureau",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Aller",
                fontSize: 12,
                fontWeight: getFontSize(1),
                color: getColor(1)),
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(
            Icons.group_rounded,
          ),
          title: Text(
            "Amis",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Aller",
                fontSize: 12,
                fontWeight: getFontSize(2),
                color: getColor(2)),
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(
            CupertinoIcons.flame,
          ),
          title: Text(
            "Défis",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Aller",
                fontSize: 12,
                fontWeight: getFontSize(3),
                color: getColor(3)),
          ),
        ),
        CustomNavigationBarItem(
          icon: CustomImageView(
            imagePath: Images.gvt,
            fit: BoxFit.contain,
          ),
          title: Text(
            "Revenus",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Aller",
                fontSize: 12,
                fontWeight: getFontSize(4),
                color: getColor(4)),
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (int index) => setState(() {
        _currentIndex = index;
      }),
      /* switch (index) {
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
        }*/
      //},
      isFloating: false,
    );
  }

  Color getColor(int index) =>
      _currentIndex == index ? Colors.white : Colors.white60;

  FontWeight getFontSize(int index) =>
      _currentIndex == index ? FontWeight.w300 : FontWeight.w500;

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
          color: const Color.fromARGB(255, 18, 54, 96),
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

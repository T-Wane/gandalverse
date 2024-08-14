import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/animations/coinsAnomations_test1.dart';
import 'package:gandalverse/core/manager/repositories/user_repo.dart';
import 'package:gandalverse/screens/Annonces/annonces_page.dart';
import 'package:gandalverse/screens/amis/amis_page.dart';
import 'package:gandalverse/screens/decouvrir/decouvir_page.dart';
import 'package:gandalverse/screens/profil/profil_screen.dart';
import 'package:gandalverse/screens/revenus/revenus_page.dart';
import 'package:gandalverse/screens/webPage/webpage.dart';
import 'package:gandalverse/core/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/bottomSheet_modal.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/percent_indicator/linear_percent_indicator.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart'; 
//import 'package:telegram_web_app/telegram_web_app.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import '../components/user_top_infos.dart';
import '../widgets/earnToTap.dart';
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

  final ScrollController _scrollController = ScrollController();
  bool _isFabVisible = true;

  final UserRepo _userRepo = UserRepo();

  final Map<String, dynamic> telegramUser = {
    'username': 'johndoe',
    'first_name': 'John',
    'last_name': 'Doe',
  };

  @override
  void initState() {
    super.initState();
    controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadRequest(
        LoadRequestParams(
          //https://gandalverse.com
          uri: Uri.parse('https://gandalverse.com'),
        ),
      );

    FlutterError.onError = (details) {
      //showSnackbar("Flutter error: $details");
      print("Flutter error happened: $details");
    };

    TelegramWebApp.instance.ready();
    check();
    _scrollController.addListener(_scrollListener);
  }

  void check() async {
    await Future.delayed(const Duration(seconds: 2));
    isDefinedVersion = await telegram.isVersionAtLeast('Bot API 6.1');
    await _userRepo.checkAndCreateUser(
      // '--', telegramUser);
        "${telegram.initDataUnsafe?.user?.id ?? '--'}", telegramUser);
    setState(() {});
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      bool isTop = _scrollController.position.pixels == 0;
      if (isTop) {
        setState(() {
          _isFabVisible = true;
        });
      } else {
        setState(() {
          _isFabVisible = false; // Hide when at the bottom
        });
      }
    } else {
      setState(() {
        _isFabVisible = true; // Show when scrolling
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isFABVisible = true; // Tracks FAB visibility
  Offset? fabPosition; // Initial position of the FAB

  void toggleFABVisibility() {
    setState(() {
      isFABVisible = !isFABVisible; // Toggle FAB visibility
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final scale = mediaQueryData.textScaleFactor;
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: /* Stack(
        children: [*/
          Scaffold(
        key: _key,
        extendBody: true,
        backgroundColor: Colors.white,

        floatingActionButton: ((_currentIndex == 1 && _isFabVisible == true) ||
                _currentIndex == 3 ||
                _currentIndex == 4)
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 1.5,
                shape: const CircleBorder(),
                onPressed: () {
                  TapToEarnCard.show(
                    context,
                    child: const FlyCoinAnimation(),
                    backColor: Color3,
                  );
                },
                child: const Icon(
                  CupertinoIcons.rocket,
                  color: Color3,
                  size: 28,
                ),
              )
            : null,
        // backgroundColor:✨ telegram.backgroundColor,
        body: IndexedStack(index: _currentIndex, children: [
          GandalVerseWebView(controller: controller),
          DecouvrirPage(scrollController: _scrollController),
          const AmisPage(),
          const AnnoncesPage(),
          const AllRevenusPage(),
        ]),

        bottomNavigationBar: _buildFloatingBarCustom(),
      ),
      // Draggable FAB
      //     PointerInterceptor(
      //       // debug: true,
      //       child: Positioned(
      //         left: fabPosition?.dx,
      //         top: fabPosition?.dy,
      //         bottom: fabPosition == null ? 50 : null,
      //         right: fabPosition == null ? 5 : null,
      //         child: Draggable(
      //           feedback: FloatingActionButton(
      //             backgroundColor: Colors.white,
      //             elevation: 1.5,
      //             shape: const CircleBorder(),
      //             onPressed: () {
      //               TapToEarnCard.show(
      //                 context,
      //                 child: const FlyCoinAnimation(),
      //                 backColor: Color3,
      //               );
      //             },
      //             child: const Icon(
      //               CupertinoIcons.rocket,
      //               color: Color3,
      //               size: 28,
      //             ),
      //           ),
      //           child: FloatingActionButton(
      //             backgroundColor: Colors.white,
      //             elevation: 1.5,
      //             shape: const CircleBorder(),
      //             onPressed: () {
      //               TapToEarnCard.show(
      //                 context,
      //                 child: const FlyCoinAnimation(),
      //                 backColor: Color3,
      //               );
      //             },
      //             child: const Icon(
      //               CupertinoIcons.rocket,
      //               color: Color3,
      //               size: 28,
      //             ),
      //           ), // Hide FAB when isFABVisible is false
      //           onDragEnd: (details) {
      //             setState(() {
      //               fabPosition =
      //                   details.offset; // Update FAB position when dragged
      //             });
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
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
            "QG",
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

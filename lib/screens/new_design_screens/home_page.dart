import 'dart:math';
import 'dart:ui';

// import 'package:flutter_web/cupertino.dart';
// import 'package:flutter_web/material.dart';
// import 'package:flutter_web/material.dart' as prefix0;
// import 'package:flutter_web/services.dart';
// import 'package:flutter_web_ui/ui.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/components/user_top_infos.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/core/route/route_name.dart';
import 'package:gandalverse/data/telegram_client.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/screens/QG_screen/QG_screen.dart';
import 'package:gandalverse/screens/amis/amis_page.dart';
import 'package:gandalverse/screens/revenus/revenus_page.dart';
import 'package:gandalverse/screens/webPage/webpage.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/fortune_spin/small_spin_widget/small_spin_widget.dart';
import 'package:gandalverse/widgets/fortune_spin/wheelSpin_fortune_modal.dart';
import 'package:gandalverse/widgets/my_profit/my_profit_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import 'components/components.dart';
import 'helper/ui_helper.dart';

import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

class HomeVrScreen extends StatefulWidget {
  HomeVrScreen();

  @override
  State<StatefulWidget> createState() {
    return _HomeVrScreenState();
  }
}

class _HomeVrScreenState extends State<HomeVrScreen>
    with TickerProviderStateMixin {
  late AnimationController animationControllerExplore; 
  late CurvedAnimation curve;
  late Animation<double> animation; 

  /// get currentOffset percent
  double get currentExplorePercent => max(0.0, min(0.9, 0.1));
  double get currentSearchPercent =>
      max(0.0, min(1.0, offsetSearch / (347 - 68.0)));
  double get currentMenuPercent => max(0.0, min(1.0, offsetMenu / 358));

  var offsetExplore = 0.0;
  var offsetSearch = 0.0;
  var offsetMenu = 0.0;

  bool isExploreOpen = false;
  bool isSearchOpen = false;
  bool isMenuOpen = false;

  /// search drag callback

  /// animate Explore
  void animateExplore(bool open) {
    setState(() {
      showExplorerContent = true;
    });

    animationControllerExplore = AnimationController(vsync: this);

    animationControllerExplore.forward();
  }

 

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool showExplorerContent = false;

  bool showAllbtns = true;

  /// Switches the visibility of the buttons on the map screen.
  void changeVisibility() {
    setState(() {
      showAllbtns = !showAllbtns;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    // if (screenWidth > standardWidth) {
    //   screenWidth = standardWidth;
    // }
    // if (screenHeight > standardHeight) {
    //   screenHeight = standardHeight;
    // }

    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onDoubleTap: changeVisibility,
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: <Widget>[
              //A decommenter
              // VerseWebView(),

              // Container(
              //   width: screenWidth,
              //   height: screenHeight,
              //   child: PlatformWebViewWidget(
              //     PlatformWebViewWidgetCreationParams(controller: controller),
              //   ).build(context),
              // ),

              //A decommenter
              Align(
                alignment: Alignment.topCenter,
                child: PointerInterceptor(
                  debug: false,
                  child: userTopInfos(
                    showVisibleEye: true,
                    changeVisibility: changeVisibility,
                  ),
                ),
              ),

              // Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Container(
              //       width: double.infinity,
              //       height: MediaQuery.of(context).size.height * 0.7,
              //       child: PointerInterceptor(
              //         debug: true,
              //         child: const SizedBox.shrink(),
              //       ),
              //     )),

              Visibility(
                visible: showAllbtns,
                child: ExploreWidget(
                  currentExplorePercent: currentExplorePercent,
                  currentSearchPercent: currentSearchPercent,
                  animateExplore: animateExplore,
                  isExploreOpen: isExploreOpen,
                  onPanDown: () => animationControllerExplore?.stop(),
                ),
              ),

              //layer button
              Visibility(
                visible: showAllbtns,
                child: MapButton(
                  bottom: 314,
                  offsetX: 0,
                  width: 68,
                  height: 71,
                  isRight: false,
                  icon: Icons.school_rounded,
                  iconColor: Themecolors.Color3,
                  title: "Learn",
                  press: () => context.pushNamed(learn_home_view),
                ),
              ),
              //directions button
              Visibility(
                visible: showAllbtns,
                child: MapButton(
                  bottom: 314,
                  offsetX: 0,
                  width: 68,
                  height: 71,
                  image: Images.gvt,
                  icon: null,
                  //icon: Icons.directions,
                  iconColor: Colors.white,
                  titleColor: Colors.white,
                  gradient: const LinearGradient(colors: [
                    Color(0xFF59C2FF),
                    Color(0xFF1270E3),
                  ]),
                  title: "Revenus",
                  press: () {
                    context.pushNamed(revenu_view);
                  },
                ),
              ),
              Visibility(
                visible: showAllbtns,
                child: MapButton(
                  bottom: 227,
                  offsetX: 0,
                  width: 68,
                  height: 71,
                  icon: CupertinoIcons.flame,
                  //icon: Icons.directions,
                  iconColor: Themecolors.Color3,
                  title: "Défis",
                  press: () {
                    context.pushNamed(defi_view);
                  },
                ),
              ),
              /* 
            //BDM Part
             Visibility(
                visible: showAllbtns,
                child: MapButton(
                  bottom: 140,
                  offsetX: 0,
                  width: 65,
                  height: 71,
                  isRight: false,
                  image: Images.logo_BDM,
                  iconColor: Themecolors.ColorWhite,
                  icon: null,
                  press: () {
                    context.pushNamed(bnda_view);
                  },
                ),
              ),*/
              //my_location button
              Visibility(
                visible: showAllbtns,
                child: MapButton(
                  bottom: 140,
                  offsetX: 0,
                  width: 68,
                  height: 71,
                  icon: Icons.group_rounded,
                  iconColor: Themecolors.Color3,
                  title: "Amis",
                  press: () {
                    context.pushNamed(amis_view);
                  },
                ),
              ),
              //layer button
              Visibility(
                visible: showAllbtns,
                child: MapButton(
                  bottom: 53,
                  offsetX: 0,
                  width: 65,
                  height: 71,
                  icon: Icons.business_rounded,
                  iconColor: Themecolors.Color3,
                  title: "QG",
                  press: () {
                    context.pushNamed(qg_view);
                  },
                ),
              ),
              Visibility(
                visible: showAllbtns,
                child: MapButton(
                  bottom: 53,
                  offsetX: 0,
                  width: 65,
                  height: 71,
                  isRight: false,
                  image: Images.scanQr,
                  iconColor: Themecolors.Color3,
                  icon: null,
                  title: "Scan",
                  press: () {
                    _showScanQrPopup();
                    // Navigator.push<void>(
                    //   context,
                    //   MaterialPageRoute<void>(
                    //     builder: (BuildContext context) => QGScreen(),
                    //   ),
                    // );
                  },
                ),
              ),
              // Visibility(
              //   visible: showAllbtns,
              //   child: SmallSpinWidget(),
              // ),
              // Visibility(
              //   visible: showAllbtns,
              //   child: MyProfitWidget(),
              // ),

              //menu button
              /* Positioned(
                bottom: realH(53),
                left: realW(-71 * (currentExplorePercent + currentSearchPercent)),
                child: GestureDetector(
                  onTap: () {
                    animateMenu(true);
                  },
                  child: PointerInterceptor(
                    child: Opacity(
                      opacity: 1 - (currentSearchPercent + currentExplorePercent),
                      child: Container(
                        width: realW(71),
                        height: realH(71),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: realW(17)),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(realW(36)),
                                topRight: Radius.circular(realW(36))),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.3),
                                  blurRadius: realW(36)),
                            ]),
                        child: Icon(
                          Icons.menu,
                          size: realW(34),
                        ),
                      ),
                    ),
                  ),
                ),
              ),*/
              //menu
              // MenuWidget(
              //     currentMenuPercent: currentMenuPercent,
              //     animateMenu: animateMenu),

              // // //menu
              // MenuWidget(
              //     currentMenuPercent: currentMenuPercent,
              //     animateMenu: animateMenu),
              //explore content
              Visibility(
                visible: showExplorerContent,
                child: PointerInterceptor(
                  debug: false,
                  child: ExploreContentWidget(close: () {
                    setState(() {
                      showExplorerContent = false;
                    });
                  }),
                  // currentExplorePercent: currentExplorePercent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//##############################################################//
  TelegramClient _telegramClient = getIt<TelegramClient>();
  UserProvider _userProvider = getIt<UserProvider>();

  Future<void> _showScanQrPopup() async {
    // Appelle la méthode showScanQrPopup
    await _telegramClient.telegram.showScanQrPopup(
      'Scanner QR code partenaire',
      (String qrText) {
        // Fonction de rappel appelée lorsque le QR code est scanné
        // Traite le texte du QR code ici

        print('QR Code scanned: $qrText');

        // Retourne true pour fermer le popup, false pour le laisser ouvert
        return true;
      },
    );
  }

//##############################################################//
  late final PlatformWebViewController controller;

  final ScrollController _scrollController = ScrollController();
  bool _isFabVisible = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _userProvider.fetchUserByTelegramId();
    });
    controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadRequest(
        LoadRequestParams(
          //https://gandalverse.com
          uri: Uri.parse('https://gandalverse.com'),
        ),
      );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    super.dispose();
    animationControllerExplore?.dispose(); 
  }
}

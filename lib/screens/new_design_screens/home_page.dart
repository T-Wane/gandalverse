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
import 'package:gandalverse/screens/QG_screen/QG_screen.dart';
import 'package:gandalverse/screens/amis/amis_page.dart';
import 'package:gandalverse/screens/revenus/revenus_page.dart';
import 'package:gandalverse/screens/webPage/webpage.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import 'components/components.dart';
import 'helper/ui_helper.dart';

import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

class GoogleMapPage extends StatefulWidget {
  GoogleMapPage();

  @override
  State<StatefulWidget> createState() {
    return _GoogleMapState();
  }
}

class _GoogleMapState extends State<GoogleMapPage>
    with TickerProviderStateMixin {
  late AnimationController animationControllerExplore;
  late AnimationController animationControllerSearch;
  late AnimationController animationControllerMenu;
  late CurvedAnimation curve;
  late Animation<double> animation;
  late Animation<double> animationW;
  late Animation<double> animationR;

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
  void onSearchHorizontalDragUpdate(details) {
    offsetSearch -= details.delta.dx;
    if (offsetSearch < 0) {
      offsetSearch = 0;
    } else if (offsetSearch > (347 - 68.0)) {
      offsetSearch = 347 - 68.0;
    }
    setState(() {});
  }

  /// explore drag callback
  void onExploreVerticalUpdate(details) {
    offsetExplore -= details.delta.dy;
    if (offsetExplore > 644) {
      offsetExplore = 644;
    } else if (offsetExplore < 0) {
      offsetExplore = 0;
    }
    setState(() {});
  }

  /// animate Explore
  void animateExplore(bool open) {
    setState(() {
      showExplorerContent = true;
    });

    animationControllerExplore = AnimationController(vsync: this);

    animationControllerExplore.forward();
  }

  void animateSearch(bool open) {
    animationControllerSearch = AnimationController(
        duration: Duration(
            milliseconds: 1 +
                (800 *
                        (isSearchOpen
                            ? currentSearchPercent
                            : (1 - currentSearchPercent)))
                    .toInt()),
        vsync: this);
    curve =
        CurvedAnimation(parent: animationControllerSearch, curve: Curves.ease);
    animation = Tween(begin: offsetSearch, end: open ? 347.0 - 68.0 : 0.0)
        .animate(curve)
      ..addListener(() {
        setState(() {
          offsetSearch = animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isSearchOpen = open;
        }
      });
    animationControllerSearch.forward();
  }

  void animateMenu(bool open) {
    animationControllerMenu =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    curve =
        CurvedAnimation(parent: animationControllerMenu, curve: Curves.ease);
    animation =
        Tween(begin: open ? 0.0 : 358.0, end: open ? 358.0 : 0.0).animate(curve)
          ..addListener(() {
            setState(() {
              offsetMenu = animation.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              isMenuOpen = open;
            }
          });
    animationControllerMenu.forward();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool showExplorerContent = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    if (screenWidth > standardWidth) {
      screenWidth = standardWidth;
    }
    if (screenHeight > standardHeight) {
      screenHeight = standardHeight;
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: <Widget>[
            Container(
              width: screenWidth,
              height: screenHeight,
              child: PlatformWebViewWidget(
                PlatformWebViewWidgetCreationParams(controller: controller),
              ).build(context),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: PointerInterceptor(
                debug: false,
                child: userTopInfos(),
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

            // Positioned(
            //   bottom: 50,
            //   left: 10,
            //   width: 50,
            //   height: 50,
            //   child: PointerInterceptor(
            //     debug: true,
            //     child: GestureDetector(
            //       onTap: () {
            //         animateMenu(true);
            //       },
            //       child: Container(
            //         decoration: const BoxDecoration(
            //             shape: BoxShape.circle, color: Colors.white),
            //         height: 50,
            //         width: 50,
            //       ),
            //     ),
            //   ),
            // ),
            //explore

            ExploreWidget(
              currentExplorePercent: currentExplorePercent,
              currentSearchPercent: currentSearchPercent,
              animateExplore: animateExplore,
              isExploreOpen: isExploreOpen,
              onVerticalDragUpdate: onExploreVerticalUpdate,
              onPanDown: () => animationControllerExplore?.stop(),
            ),

            //blur
            offsetSearch != 0
                ? BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 10 * currentSearchPercent,
                        sigmaY: 10 * currentSearchPercent),
                    child: Container(
                      color:
                          Colors.white.withOpacity(0.1 * currentSearchPercent),
                      width: screenWidth,
                      height: screenHeight,
                    ),
                  )
                : const Padding(
                    padding: const EdgeInsets.all(0),
                  ),

            //recent search
            RecentSearchWidget(
              currentSearchPercent: currentSearchPercent,
            ),
            //search menu background
            offsetSearch != 0
                ? Positioned(
                    bottom: realH(88),
                    left: realW((standardWidth - 320) / 2),
                    width: realW(320),
                    height: realH(135 * currentSearchPercent),
                    child: Opacity(
                      opacity: currentSearchPercent,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(realW(33)),
                                topRight: Radius.circular(realW(33)))),
                      ),
                    ),
                  )
                : const Padding(
                    padding: const EdgeInsets.all(0),
                  ),
            //search menu
            // SearchMenuWidget(
            //   currentSearchPercent: currentSearchPercent,
            // ),
            // //search
            // SearchWidget(
            //   currentSearchPercent: currentSearchPercent,
            //   currentExplorePercent: currentExplorePercent,
            //   isSearchOpen: isSearchOpen,
            //   animateSearch: animateSearch,
            //   onHorizontalDragUpdate: onSearchHorizontalDragUpdate,
            //   onPanDown: () => animationControllerSearch?.stop(),
            // ),
            // //search back
            // SearchBackWidget(
            //   currentSearchPercent: currentSearchPercent,
            //   animateSearch: animateSearch,
            // ),
            //layer button
            MapButton(
              bottom: 243,
              offsetX: 0,
              width: 71,
              height: 71,
              isRight: false,
              icon: Icons.layers,
            ),
            //directions button
            MapButton(
              bottom: 243,
              offsetX: 0,
              width: 68,
              height: 71,
              image: Images.gvt,
              icon: null,
              //icon: Icons.directions,
              iconColor: Colors.white,
              gradient: const LinearGradient(colors: [
                Color(0xFF59C2FF),
                Color(0xFF1270E3),
              ]),
              press: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const AllRevenusPage(),
                  ),
                );
              },
            ),
            //my_location button
            MapButton(
              bottom: 148,
              offsetX: 0,
              width: 68,
              height: 71,
              icon: Icons.group_rounded,
              iconColor: Colors.blue,
              press: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const AmisPage(),
                  ),
                );
              },
            ),
            //layer button
            MapButton(
              bottom: 53,
              offsetX: 0,
              width: 65,
              height: 71,
              icon: Icons.business_rounded,
              press: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => QGScreen(),
                  ),
                );
              },
            ),
            //menu button
            Positioned(
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
            ),
            //menu
            MenuWidget(
                currentMenuPercent: currentMenuPercent,
                animateMenu: animateMenu),

            // //menu
            MenuWidget(
                currentMenuPercent: currentMenuPercent,
                animateMenu: animateMenu),
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
    );
  }

//##############################################################//
  late final PlatformWebViewController controller;

  final ScrollController _scrollController = ScrollController();
  bool _isFabVisible = true;

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

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    super.dispose();
    animationControllerExplore?.dispose();
    animationControllerSearch?.dispose();
    animationControllerMenu?.dispose();
  }
}

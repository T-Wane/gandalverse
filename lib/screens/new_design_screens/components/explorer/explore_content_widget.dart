import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gandalverse/components/rounded_btn_back.dart';
import 'package:gandalverse/core/services/explorer_service/explorer_service.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/screens/new_design_screens/components/explorer/categories_section.dart';
import 'package:gandalverse/screens/new_design_screens/components/explorer/events_section.dart';
import 'package:gandalverse/screens/new_design_screens/helper/ui_helper.dart';
import 'package:gandalverse/themes/color/themeColors.dart';

class ExploreContentWidget extends StatefulWidget {
  // final double currentExplorePercent;
  VoidCallback close;
  ExploreContentWidget({Key? key, required this.close}) : super(key: key);

  @override
  State<ExploreContentWidget> createState() => _ExploreContentWidgetState();
}

class _ExploreContentWidgetState extends State<ExploreContentWidget> {
  ExplorerService _explorerService = getIt<ExplorerService>();
  final placeName = const [
    "Authentic\nrestaurant",
    "Famous\nmonuments",
    "Weekend\ngetaways"
  ];

  final DraggableScrollableController _controller =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_checkIfSheetClosed);
  }

  void _checkIfSheetClosed() {
    if (_controller.size == 0.0) {
      // Exécutez votre fonction ici
      _onSheetClosed();
    }
  }

  void _onSheetClosed() {
    // Fonction à exécuter lorsque le panneau est complètement fermé
    print('Le panneau est complètement fermé.');
    widget.close.call();
  }

  @override
  void dispose() {
    _controller.removeListener(_checkIfSheetClosed);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.0,
        maxChildSize: 0.9,
        shouldCloseOnMinExtent: true,
        snap: true,
        controller: _controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: AnimatedContainer(
              height: screenHeight,
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: Colors.purpleAccent.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.purpleAccent.withOpacity(0.4),
                        offset: const Offset(1, 1),
                        blurRadius: 10,
                        spreadRadius: 4)
                  ]),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Themecolors.Color3,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(controller: scrollController, children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: BtnRoundedIconBack(
                        onpress: () {
                          widget.close.call();
                          // Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        CategoriesSection(),
                        EventsSection()
                        // Opacity(
                        //   opacity: widget.currentExplorePercent,
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.max,
                        //     children: <Widget>[
                        //       Expanded(
                        //         child: Transform.translate(
                        //           offset: Offset(
                        //               screenWidth /
                        //                   3 *
                        //                   (1 - widget.currentExplorePercent),
                        //               screenWidth /
                        //                   3 /
                        //                   2 *
                        //                   (1 - widget.currentExplorePercent)),
                        //           child: Image.asset(
                        //             "assets/images/new/icon_1.png",
                        //             width: realH(133),
                        //             height: realH(133),
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: Image.asset(
                        //           "assets/images/new/icon_2.png",
                        //           width: realH(133),
                        //           height: realH(133),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: Transform.translate(
                        //           offset: Offset(
                        //               -screenWidth /
                        //                   3 *
                        //                   (1 - widget.currentExplorePercent),
                        //               screenWidth /
                        //                   3 /
                        //                   2 *
                        //                   (1 - widget.currentExplorePercent)),
                        //           child: Image.asset(
                        //             "assets/images/new/icon_3.png",
                        //             width: realH(133),
                        //             height: realH(133),
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Transform.translate(
                        //     offset: Offset(
                        //         0,
                        //         realH(23 +
                        //             380 * (1 - widget.currentExplorePercent))),
                        //     child: Opacity(
                        //         opacity: widget.currentExplorePercent,
                        //         child: Container(
                        //           width: screenWidth,
                        //           height: realH(172 +
                        //               (172 *
                        //                   4 *
                        //                   (1 - widget.currentExplorePercent))),
                        //           child: ListView(
                        //             physics: const BouncingScrollPhysics(),
                        //             scrollDirection: Axis.horizontal,
                        //             children: <Widget>[
                        //               Padding(
                        //                 padding: EdgeInsets.only(left: realW(22)),
                        //               ),
                        //               buildListItem(0, "Authentic\nrestaurant"),
                        //               buildListItem(1, "Famous\nmonuments"),
                        //               buildListItem(2, "Weekend\ngetaways"),
                        //               buildListItem(3, "Authentic\nrestaurant"),
                        //               buildListItem(4, "Famous\nmonuments"),
                        //               buildListItem(5, "Weekend\ngetaways"),
                        //             ],
                        //           ),
                        //         ))),
                        // Transform.translate(
                        //     offset: Offset(
                        //         0,
                        //         realH(58 +
                        //             570 * (1 - widget.currentExplorePercent))),
                        //     child: Opacity(
                        //       opacity: widget.currentExplorePercent,
                        //       child: Padding(
                        //         padding:
                        //             EdgeInsets.symmetric(horizontal: realW(22)),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           mainAxisSize: MainAxisSize.max,
                        //           children: <Widget>[
                        //             Padding(
                        //               padding: EdgeInsets.only(left: realW(22)),
                        //               child: Text("EVENTS",
                        //                   style: const TextStyle(
                        //                       color: Colors.white54,
                        //                       fontSize: 13,
                        //                       fontWeight: FontWeight.bold)),
                        //             ),
                        //             Stack(
                        //               children: <Widget>[
                        //                 Image.asset(
                        //                   "assets/images/new/dj.png",
                        //                 ),
                        //                 Positioned(
                        //                     bottom: realH(26),
                        //                     left: realW(24),
                        //                     child: Text(
                        //                       "Marshmello Live in Concert",
                        //                       style: TextStyle(
                        //                           color: Colors.white,
                        //                           fontSize: realW(16)),
                        //                     ))
                        //               ],
                        //             ),
                        //             Transform.translate(
                        //               offset: Offset(
                        //                   0,
                        //                   realH(30 -
                        //                       30 *
                        //                           (widget.currentExplorePercent -
                        //                               0.75) *
                        //                           4)),
                        //               child: Row(
                        //                 children: <Widget>[
                        //                   Expanded(
                        //                     child: Image.asset(
                        //                         "assets/images/new/banner_4.png"),
                        //                   ),
                        //                   Expanded(
                        //                     child: Image.asset(
                        //                         "assets/images/new/banner_5.png"),
                        //                   ),
                        //                 ],
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     )),
                        // Padding(
                        //   padding: EdgeInsets.only(bottom: realH(262)),
                        // )
                      ]),
                ]),
              ),
            ),
          );
        });
  }

  // buildListItem(int index, String name) {
  //   return Transform.translate(
  //     offset:
  //         Offset(0, index * realH(127) * (1 - widget.currentExplorePercent)),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         Image.asset(
  //           "assets/images/new/banner_${index % 3 + 1}.png",
  //           width: realH(127),
  //           height: realH(127),
  //         ),
  //         Text(
  //           placeName[index % 3],
  //           style: TextStyle(color: Colors.white, fontSize: realH(16)),
  //           textAlign: TextAlign.center,
  //         )
  //       ],
  //     ),
  //   );
  // }
}

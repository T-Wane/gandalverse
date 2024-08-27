import 'package:flutter/material.dart';
import 'package:gandalverse/screens/profil/profil_screen.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../helper/ui_helper.dart';

class ExploreWidget extends StatelessWidget {
  final double currentSearchPercent;

  final double currentExplorePercent;

  final Function(bool) animateExplore;

  final Function(DragUpdateDetails) onVerticalDragUpdate;
  final Function() onPanDown;

  final bool isExploreOpen;

  const ExploreWidget(
      {Key? key,
      required this.currentSearchPercent,
      required this.currentExplorePercent,
      required this.animateExplore,
      required this.isExploreOpen,
      required this.onVerticalDragUpdate,
      required this.onPanDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: realH(-122 * currentSearchPercent),
      left: (screenWidth -
              realW(159 + (standardWidth - 159) * currentExplorePercent)) /
          2,
      child: GestureDetector(
        onTap: () {
          animateExplore(!isExploreOpen);
          // Navigator.push<void>(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => MonProfilScreen(),
          //   ),
          // );
        },
        onVerticalDragUpdate: onVerticalDragUpdate,
        onVerticalDragEnd: (_) {
          _dispatchExploreOffset();
        },
        onPanDown: (_) => onPanDown(),
        child: Opacity(
          opacity: 1 - currentSearchPercent,
          child: PointerInterceptor(
            child: Container(
              alignment: Alignment.bottomCenter,
              width: realW(159 + (standardWidth - 159) * currentExplorePercent),
              height: realH(122 + (766 - 122) * currentExplorePercent),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.deepPurple.shade300,
                        Colors.deepPurple.shade400,
                        Colors.deepPurple.shade600,
                        Colors.deepPurple,
                      ]),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          realW(80 + (50 - 80) * currentExplorePercent)),
                      topRight: Radius.circular(
                          realW(80 + (50 - 80) * currentExplorePercent)))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Explorer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            realW(18 + (32 - 18) * currentExplorePercent)),
                  ),
                  Icon(
                    Icons.location_on,
                    size: realW(34),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// dispatch Explore state
  ///
  /// handle it by [widget.isExploreOpen] and [widget.currentExplorePercent]
  void _dispatchExploreOffset() {
    if (!isExploreOpen) {
      if (currentExplorePercent < 0.3) {
        animateExplore(false);
      } else {
        animateExplore(true);
      }
    } else {
      if (currentExplorePercent > 0.6) {
        animateExplore(true);
      } else {
        animateExplore(false);
      }
    }
  }
}

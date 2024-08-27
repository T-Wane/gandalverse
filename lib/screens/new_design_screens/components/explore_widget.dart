import 'package:flutter/material.dart';
import 'package:gandalverse/screens/profil/profil_screen.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../helper/ui_helper.dart';

class ExploreWidget extends StatefulWidget {
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
  State<ExploreWidget> createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      elevation: 1.2,
      borderOnForeground: true,
      surfaceTintColor: Colors.deepPurple,
      color: Colors.deepPurple.withOpacity(0.9),
      shadowColor: const Color.fromARGB(255, 151, 116, 211).withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: PointerInterceptor(
        child: GestureDetector(
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => MonProfilScreen(),
              ),
            );
          },
          child: Container(
            alignment: Alignment.bottomCenter,
            width: realW(
                159 + (standardWidth - 159) * widget.currentExplorePercent),
            height: realH(122 + (766 - 122) * widget.currentExplorePercent),
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
                        realW(80 + (50 - 80) * widget.currentExplorePercent)),
                    topRight: Radius.circular(
                        realW(80 + (50 - 80) * widget.currentExplorePercent)))),
          ),
        ),
      ),
    );
    /*Positioned(
      bottom: realH(-122 * currentSearchPercent),
      left: (screenWidth -
              realW(159 + (standardWidth - 159) * currentExplorePercent)) /
          2,
      child: PointerInterceptor(
        child: GestureDetector(
          onTap: () {
            // animateExplore(!isExploreOpen);
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => MonProfilScreen(),
              ),
            );
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
                width:
                    realW(159 + (standardWidth - 159) * currentExplorePercent),
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
      ),
    );*/
  }

  /// dispatch Explore state
  ///
  /// handle it by [widget.isExploreOpen] and [widget.currentExplorePercent]
  void _dispatchExploreOffset() {
    if (!widget.isExploreOpen) {
      if (widget.currentExplorePercent < 0.3) {
        widget.animateExplore(false);
      } else {
        widget.animateExplore(true);
      }
    } else {
      if (widget.currentExplorePercent > 0.6) {
        widget.animateExplore(true);
      } else {
        widget.animateExplore(false);
      }
    }
  }
}

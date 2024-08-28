import 'package:flutter/material.dart';
import 'package:gandalverse/core/services/explorer_service/explorer_service.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/screens/new_design_screens/helper/ui_helper.dart';

class ExploreContentWidget extends StatefulWidget {
  final double currentExplorePercent;

  const ExploreContentWidget({Key? key, required this.currentExplorePercent})
      : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    if (widget.currentExplorePercent != 0) {
      return Positioned(
        top: realH(standardHeight +
            (162 - standardHeight) * widget.currentExplorePercent),
        width: screenWidth,
        child: Container(
          height: screenHeight,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Opacity(
                opacity: widget.currentExplorePercent,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Transform.translate(
                        offset: Offset(
                            screenWidth /
                                3 *
                                (1 - widget.currentExplorePercent),
                            screenWidth /
                                3 /
                                2 *
                                (1 - widget.currentExplorePercent)),
                        child: Image.asset(
                          "assets/images/new/icon_1.png",
                          width: realH(133),
                          height: realH(133),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        "assets/images/new/icon_2.png",
                        width: realH(133),
                        height: realH(133),
                      ),
                    ),
                    Expanded(
                      child: Transform.translate(
                        offset: Offset(
                            -screenWidth /
                                3 *
                                (1 - widget.currentExplorePercent),
                            screenWidth /
                                3 /
                                2 *
                                (1 - widget.currentExplorePercent)),
                        child: Image.asset(
                          "assets/images/new/icon_3.png",
                          width: realH(133),
                          height: realH(133),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(
                    0, realH(23 + 380 * (1 - widget.currentExplorePercent))),
                child: Opacity(
                  opacity: widget.currentExplorePercent,
                  child: Container(
                    width: screenWidth,
                    height: realH(
                        172 + (172 * 4 * (1 - widget.currentExplorePercent))),
                    child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: realW(22)),
                          ),
                          buildListItem(0, "Authentic\nrestaurant"),
                          buildListItem(1, "Famous\nmonuments"),
                          buildListItem(2, "Weekend\ngetaways"),
                          buildListItem(3, "Authentic\nrestaurant"),
                          buildListItem(4, "Famous\nmonuments"),
                          buildListItem(5, "Weekend\ngetaways"),
                        ]),
                  ),
                ),
              ),
              Transform.translate(
                  offset: Offset(
                      0, realH(58 + 570 * (1 - widget.currentExplorePercent))),
                  child: Opacity(
                    opacity: widget.currentExplorePercent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: realW(22)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: realW(22)),
                            child: const Text("EVENTS",
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/new/dj.png",
                              ),
                              Positioned(
                                  bottom: realH(26),
                                  left: realW(24),
                                  child: Text(
                                    "Marshmello Live in Concert",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: realW(16)),
                                  ))
                            ],
                          ),
                          Transform.translate(
                            offset: Offset(
                                0,
                                realH(30 -
                                    30 *
                                        (widget.currentExplorePercent - 0.75) *
                                        4)),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Image.asset(
                                      "assets/images/new/banner_4.png"),
                                ),
                                Expanded(
                                  child: Image.asset(
                                      "assets/images/new/banner_5.png"),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(bottom: realH(262)),
              )
            ],
          ),
        ),
      );
    } else {
      return const Padding(
        padding: const EdgeInsets.all(0),
      );
    }
  }

  buildListItem(int index, String name) {
    return Transform.translate(
      offset:
          Offset(0, index * realH(127) * (1 - widget.currentExplorePercent)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "assets/images/new/banner_${index % 3 + 1}.png",
            width: realH(127),
            height: realH(127),
          ),
          Text(
            placeName[index % 3],
            style: TextStyle(color: Colors.white, fontSize: realH(16)),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

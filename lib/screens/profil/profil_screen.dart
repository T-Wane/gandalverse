import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/components/rounded_btn_back.dart';
import 'package:gandalverse/core/data/levels.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/screens/profil/components/user_icon.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/percent_indicator/linear_percent_indicator.dart';
import 'package:gandalverse/widgets/profilDetails_bottomSheet.dart';
import 'package:go_router/go_router.dart';
import 'components/infos_card.dart';

class MonProfilScreen extends StatefulWidget {
  MonProfilScreen({super.key});

  @override
  State<MonProfilScreen> createState() => _MonProfilScreenState();
}

class _MonProfilScreenState extends State<MonProfilScreen> {
  late PageController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = PageController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Fonction pour faire défiler vers la gauche
  void _scrollLeft() {
    final page = _scrollController.page ?? 0;
    if (page > 0) {
      _scrollController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Fonction pour faire défiler vers la droite
  void _scrollRight() {
    final page = _scrollController.page ?? 0;
    if (page < (levels.length - 1)) {
      _scrollController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /*  entry.value['image']*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 17, 19),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        minimum: const EdgeInsets.all(5),
        child: Stack(children: [
          Column(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: BtnRoundedIconBack(
                  onpress: () {
                    //Navigator.of(context).pop();
                     Navigator.pop(context);
                  },
                ),
              ),
            ),
            Flexible(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                children: levels.entries
                    .map((entry) => Column(children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purpleAccent.withOpacity(0.2),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.purpleAccent.withOpacity(0.1),
                                ),
                                child: CustomImageView(
                                  margin: const EdgeInsets.all(5),
                                  height: 180,
                                  width: 180,
                                  imagePath:
                                      entry.value['image'], //image du niveau
                                  radius: BorderRadius.circular(90),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    onPressed: () {
                                      _scrollLeft();
                                    },
                                    icon: Icon(
                                      CupertinoIcons.chevron_left,
                                      color: Themecolors.ColorWhite,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    child: Text(
                                      "${entry.value['title']}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Themecolors.ColorWhite
                                              .withOpacity(0.9),
                                          fontFamily: "Aller",
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    onPressed: () {
                                      _scrollRight();
                                    },
                                    icon: Icon(
                                      CupertinoIcons.chevron_right,
                                      color: Themecolors.ColorWhite,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (entry.value['title'] == "Neo") ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 10),
                              child: LinearPercentIndicator(
                                percent: 0.5,
                                isRTL: false,
                                backgroundColor:
                                    Themecolors.ColorWhite.withOpacity(0.3),
                                animateFromLastPercent: true,
                                restartAnimation: true,
                                linearGradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.deepPurple.shade200,
                                      Colors.deepPurple.shade300,
                                      Colors.deepPurple.shade400,
                                      Colors.deepPurple.shade400,
                                      Colors.deepPurple.shade500,
                                      Colors.deepPurple.shade600,
                                      Colors.deepPurple.shade700,
                                    ]),
                                lineHeight: 20.0,
                                barRadius: const Radius.circular(5),
                                leading: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 2),
                                  child: Text(
                                    "4k",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Themecolors.ColorWhite,
                                      fontFamily: "Aller",
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                trailing: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 2),
                                  child: Text(
                                    "${entry.value['coins_required']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.purple.shade400,
                                        fontFamily: "Aller",
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            )
                          ],
                          const SizedBox(
                            height: 5,
                          ),
                          Spacer()

                          /// Expanded(child: PlayerList())
                        ]))
                    .toList(),
              ),
            ),
          ]),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: shareGvBtn(),
          )
        ]),
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/animations/coinsAnomations_test1.dart';
import 'package:gandalverse/components/rounded_btn_back.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/screens/QG_screen/components/itemCard.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/screens/QG_screen/sections/partenaire_section.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/earnToTap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/user_top_infos.dart';
import '../../widgets/tab_element.dart';
import 'sections/equipe_section.dart';

class QGScreen extends StatefulWidget {
  QGScreen({super.key, this.scrollController});
  ScrollController? scrollController;
  @override
  State<QGScreen> createState() => _QGScreenState();
}

class _QGScreenState extends State<QGScreen> {
  UserProvider _userProvider = getIt<UserProvider>();

  final _selectedSegment = ValueNotifier('Equipe');
  final Map<String, String> sections = {
    "Equipe": "Equipe",
    "Partenaire": "Partenaire",
  };
  Color Color3 = const Color.fromARGB(255, 18, 40, 70);

  final ScrollController _scrollController = ScrollController();
  bool _isFabVisible = true;

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
    final screen_size_width = MediaQuery.of(context).size.width;
    final screen_size_height = MediaQuery.of(context).size.height;
    // Calculer la largeur de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    // Définir une largeur fixe pour chaque carte
    final cardWidth = 180.0;
    // Calculer le nombre de colonnes basé sur la largeur de l'écran
    final crossAxisCount = (screenWidth / cardWidth).floor();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 17, 19),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.all(5.0),
            //     child: BtnRoundedIconBack(
            //       onpress: () {
            //         // Navigator.of(context).pop();
            //         context.pop();
            //       },
            //     ),
            //   ),
            // ),
            userTopInfos(
              showBackArrow: true,
            ), // Toujours en haut
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: Images.coin_dollar,
                    fit: BoxFit.contain,
                    height: 35,
                    width: 35,
                  ),
                  const SizedBox(width: 5),
                  AutoSizeText(
                    "${context.watch<UserProvider>().user?.coins ?? 0}",
                    //"${_userProvider.user?.coins ?? 0}",
                    maxLines: 1,
                    presetFontSizes: [25, 22, 20, 18, 15, 14],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Aller",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: AdvancedSegment(
                inactiveStyle: const TextStyle(color: Colors.white),
                controller: _selectedSegment,
                backgroundColor: Color3.withOpacity(0.8),
                segments: sections,
              ),
            ),
            Expanded(
              child: ListView(
                controller: _scrollController,
                children: [
                  ValueListenableBuilder<String>(
                    valueListenable: _selectedSegment,
                    builder: (_, key, __) {
                      if (_selectedSegment.value == "Equipe") {
                        return EquipeSection();
                      }
                      if (_selectedSegment.value == "Partenaire") {
                        return PartenaireSection();
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 100),
                            physics: const NeverScrollableScrollPhysics(),
                            // gridDelegate:
                            //     const SliverGridDelegateWithMaxCrossAxisExtent(
                            //   maxCrossAxisExtent: 180,
                            //   mainAxisExtent: 170,
                            //   crossAxisSpacing: 1,
                            //   mainAxisSpacing: 1,
                            // ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisExtent: 170,
                              // childAspectRatio:
                              //     cardWidth / 100, // Ratio largeur/hauteur
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemCount: 8,
                            itemBuilder: (BuildContext ctx, index) {
                              return itemCard();
                            },
                          ),
                        );
                      }
                    },
                  ),
                  FlyCoinAnimation(), // L'animation reste après la grille
                  earnToTapBottomWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

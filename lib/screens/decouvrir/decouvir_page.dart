import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/animations/coinsAnomations_test1.dart';
import 'package:gandalverse/screens/decouvrir/components/itemCard.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/screens/decouvrir/sections/partenaire_section.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/earnToTap.dart';

import '../../components/user_top_infos.dart';
import '../../widgets/tab_element.dart';
import 'sections/equipe_section.dart';

class DecouvrirPage extends StatefulWidget {
  DecouvrirPage({super.key, required this.scrollController});
  ScrollController scrollController;
  @override
  State<DecouvrirPage> createState() => _DecouvrirPageState();
}

class _DecouvrirPageState extends State<DecouvrirPage> {
  final _selectedSegment = ValueNotifier('Equipe');
  final Map<String, String> sections = {
    "Equipe": "Equipe",
    "Partenaire": "Partenaire",
  };
  Color Color3 = const Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 17, 19),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            userTopInfos(), // Toujours en haut
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: Images.gvt,
                    fit: BoxFit.contain,
                    height: 35,
                    width: 35,
                  ),
                  const SizedBox(width: 5),
                  const AutoSizeText(
                    '100 500 000',
                    maxLines: 1,
                    presetFontSizes: [25, 22, 20, 18, 15, 14],
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
                controller: widget.scrollController,
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
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 180,
                              mainAxisExtent: 170,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
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

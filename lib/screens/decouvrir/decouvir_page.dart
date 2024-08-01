import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/screens/decouvrir/components/itemCard.dart';
import 'package:gandalverse/core/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';

import '../../components/user_top_infos.dart';
import '../../widgets/tab_element.dart';
import 'sections/equipe_section.dart';

class DecouvrirPage extends StatefulWidget {
  const DecouvrirPage({super.key});

  @override
  State<DecouvrirPage> createState() => _DecouvrirPageState();
}

class _DecouvrirPageState extends State<DecouvrirPage> {
  final ScrollController _scrollController = ScrollController();
  final _selectedSegment = ValueNotifier('Equipe');
  final Map<String, String> sections = {
    "Equipe": "Equipe",
    "Partenaire": "Partenaire",
    // "Education": "Education",
    // "Tourisme": "Tourisme",
    // "Evenement": "Evenement",
  };
  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 12, 17, 19),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(children: [

        userTopInfos(),
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
              const SizedBox(
                width: 5,
              ),
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
        Flexible(
          child: ValueListenableBuilder<String>(
              valueListenable: _selectedSegment,
              builder: (_, key, __) {
                if (_selectedSegment.value == "Equipe") {
                  return EquipeSection();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GridView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 100),
                        // physics: const NeverScrollableScrollPhysics(),
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
                        }),
                  );
                }
              }),
        ),
      ]),
    );
  }
}

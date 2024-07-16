import 'package:flutter/material.dart';
import 'package:gandalverse/screens/decouvrir/components/itemCard.dart';

import '../../widgets/tab_element.dart';

class DecouvrirPage extends StatefulWidget {
  const DecouvrirPage({super.key});

  @override
  State<DecouvrirPage> createState() => _DecouvrirPageState();
}

class _DecouvrirPageState extends State<DecouvrirPage> {
  final ScrollController _scrollController = ScrollController();
  final _selectedSegment = ValueNotifier('Tous');
  final Map<String, String> sections = {
    "Tous": "Tous",
    "Entreprise": "Entreprise",
    "Expositions": "Expositions",
    "Publicités": "Publicités"
  };
  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: AdvancedSegment(
              inactiveStyle: const TextStyle(color: Colors.white),
              controller: _selectedSegment,
              backgroundColor: Color3.withOpacity(0.8),
              segments: sections,
            ),
          ),
          ValueListenableBuilder<String>(
              valueListenable: _selectedSegment,
              builder: (_, key, __) {
                return GridView.builder(
                    controller: _scrollController,
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      mainAxisExtent: 180,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: 5,
                    itemBuilder: (BuildContext ctx, index) {
                      return itemCard();
                    });
              })
        ],
      ),
    );
  }
}

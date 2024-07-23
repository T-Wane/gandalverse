import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/screens/decouvrir/components/itemCard.dart';

import '../../components/user_top_infos.dart';
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
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(children: [
        const userTopInfos(),
        /*Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Découvrir",
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color3,
                  fontFamily: "Aller",
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),*/
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
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
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GridView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 80),
                      // physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 180,
                        mainAxisExtent: 200,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: 8,
                      itemBuilder: (BuildContext ctx, index) {
                        return itemCard();
                      }),
                );
              }),
        ),
      ]),
    );
  }
}

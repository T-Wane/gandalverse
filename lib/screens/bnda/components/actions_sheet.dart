 
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_modal.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class ActionsSheet extends StatefulWidget {
  ActionsSheet(
      {super.key, required this.setAllAgences, required this.setNearByAgences});

  VoidCallback setAllAgences;
  VoidCallback setNearByAgences;

  @override
  State<ActionsSheet> createState() =>
      _ActionsSheetState();
}

class _ActionsSheetState
    extends State<ActionsSheet> {
  final ScrollController _controller = ScrollController();
  List<Map<String, dynamic>> _getData() {
    List<Map<String, dynamic>> list = [
      {"titre": "Agences Proches", "icon": CupertinoIcons.location},
      {"titre": "Toutes les Agences", "icon": Icons.account_balance_rounded},
      {"titre": "Favoris", "icon": CupertinoIcons.heart},
    ];

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Themecolors.ColorDeepBlue.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 0.5,
            offset: Offset(0, -2),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 4,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade600.withOpacity(0.5)),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "👋Salut",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 15,
                    color: Themecolors.Color3,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Voici les agences les plus proches de vous",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 13,
                  color: Themecolors.Color3,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: GridView.builder(
              controller: _controller,
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 5),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 8 / 6,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: _getData().length,
              itemBuilder: (BuildContext ctx, index) {
                Map<String, dynamic> item = _getData()[index];
                return InkWell(
                  onTap: () {
                    if (item['titre'] == "Agences Proches") {
                      print("#### Nouveau trajet");
                      setState(() {
                        widget.setNearByAgences();
                      });
                    }
                    if (item['titre'] == "Toutes les Agences") {
                      print("#### Nouveau trajet");
                      setState(() {
                        widget.setAllAgences();
                      });
                    } else {
                      CustomBottomModalSheet.show(context,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: CustomImageView(
                                  imagePath: Images.ticket_box,
                                  fit: BoxFit.contain,
                                  height: 150,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: AutoSizeText(
                                  "Pas de Chauffeur en favoris",
                                  presetFontSizes: const [13, 12],
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.ltr,
                                  style: const TextStyle(
                                      fontFamily: "Aller",
                                      color: Themecolors.greyDeep),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                          titre: "⭐️ Mes Favoris");
                    }
                  },
                  child: Card(
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    elevation: 0.5,
                    shadowColor: Themecolors.Color3.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Themecolors.greyDeep.withOpacity(0.2),
                          width: 1.2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    //color: Colors.transparent,playstore
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Themecolors.greyDeep.withOpacity(0.04),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Icon(item['icon']),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    item['titre'],
                                    presetFontSizes: const [12, 11, 10],
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Themecolors.greyDeep,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          //  const Spacer(),
          // DefaultButton(
          //     height: 40,
          //     paddingV: 5,
          //     fontSize: 14,
          //     textColor: Themecolors.white,
          //     backColor: Themecolors.blue,
          //     text: "ENVOYER",
          //     press: () {
          //       //Navigator.pushNamed(context, RegisterPage.route);
          //     }),
        ],
      ),
    );
  }
}

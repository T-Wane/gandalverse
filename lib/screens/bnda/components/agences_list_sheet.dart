import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/screens/bnda/components/agence_item.dart';
import 'package:gandalverse/screens/bnda/modeles/agence.dart';
import 'package:gandalverse/themes/color/themeColors.dart';

class AgencesListSheet extends StatelessWidget {
  AgencesListSheet(
      {super.key,
      required this.close,
      required this.agences,
      required this.title,
      required this.zoomOnAgence});

  VoidCallback close;
  List<Agence> agences;
  String title;
  Future<void> Function(Agence agence) zoomOnAgence;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.5,
      maxChildSize: 0.6,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Themecolors.Color3.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 0.5,
                offset: Offset(0, -2),
              )
            ],
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 4,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Themecolors.greyDeep.withOpacity(0.5)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Themecolors.greyDeep,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: close,
                      icon: const Icon(CupertinoIcons.clear_circled),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  controller: scrollController,
                  itemCount: agences.length, // Example item count
                  itemBuilder: (BuildContext context, int index) {
                    Agence _agence = agences[index];
                    return AgenceItem(index: index, agence: _agence,zoomOn:zoomOnAgence);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

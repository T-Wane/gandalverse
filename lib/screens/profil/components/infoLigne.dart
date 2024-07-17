import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class detailsLigne extends StatelessWidget {
  final String titre;
  final String data;
  final int nLigneTitre;
  final int nLigne;
  Color titreColor;
  Color dataColor;
  bool setContenu_bold;
  bool setContenu_nearbyTitle;
  bool setTitre_bold;
  bool setContenu_italic;
  bool showData;
  double maxFontTitre;
  double maxFontData;
  double paddingV;
  double paddingH;
  detailsLigne({
    required this.titre,
    required this.data,
    required this.nLigne,
    this.nLigneTitre = 1,
    this.titreColor = Colors.black,
    this.dataColor = Colors.black,
    this.setTitre_bold = true,
    this.setContenu_bold = false,
    this.setContenu_nearbyTitle = false,
    this.setContenu_italic = false,
    this.showData = false,
    this.maxFontData = 12,
    this.maxFontTitre = 12,
    this.paddingH = 5,
    this.paddingV = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AutoSizeText(
              "$titre ",
              minFontSize: 11,
              maxLines: nLigneTitre,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: "Aller",
                fontSize: maxFontTitre,
                color: titreColor,
                fontWeight: setTitre_bold ? FontWeight.normal : FontWeight.w400,
              ),
            ),
          ),
          if (showData == true) ...[
            Expanded(
              child: AutoSizeText(
                "$data ",
                maxLines: nLigne,
                minFontSize: 11,
                textAlign:
                    setContenu_nearbyTitle ? TextAlign.left : TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "Aller",
                  fontSize: maxFontData,
                  fontStyle:
                      setContenu_italic ? FontStyle.italic : FontStyle.normal,
                  color: dataColor,
                  fontWeight:
                      setContenu_bold ? FontWeight.normal : FontWeight.normal,
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}

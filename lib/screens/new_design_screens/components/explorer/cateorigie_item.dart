import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/explorer/categorie/categorie.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class CategorieTypeItem extends StatelessWidget {
  CategorieTypeItem(
      {super.key,
      required this.couleur,
      required this.onPress,
      required this.type});

  CategorieType? type;
  Color couleur;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress as void Function()?,
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.blueAccent.withOpacity(0.2),
                offset: Offset(0, 1),
                spreadRadius: 0.2),
          ],
          color: couleur.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: CustomImageView(
                  imagePath: type?.imageAsset ?? Images.badge,
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: AutoSizeText(
                  type?.name ?? '---',
                  presetFontSizes: const [13, 12, 11],
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                    color: couleur,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

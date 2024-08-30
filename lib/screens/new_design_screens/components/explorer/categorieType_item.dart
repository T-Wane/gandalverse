import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/explorer/categorie/categorie.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class CategorieTypeItem extends StatelessWidget {
  CategorieTypeItem(
      {super.key,
      required this.couleur,
      required this.onPress,
      required this.type,
      required this.isSelected});

  bool isSelected;
  CategorieType? type;
  Color couleur;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress as void Function()?,
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(width: 1.0, color: Colors.deepPurple)
              : null,
          color: couleur.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: CustomImageView(
                  imagePath: type?.imageAsset ?? Images.badge,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Flexible(
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

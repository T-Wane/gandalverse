import 'package:flutter/material.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class BtnRoundedIconBack extends StatelessWidget {
  final Function? onpress;
  Color couleur;
  BtnRoundedIconBack(
      {super.key,
      required this.onpress,
      this.couleur = Colors.white});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onpress as void Function()?,
      child: Container(
        decoration: BoxDecoration(
            color: couleur.withOpacity(0.3),
            shape: BoxShape.circle),
        padding: const EdgeInsets.all(12),
        child: CustomImageView(
          imagePath: Images.leftArrow,
          height: 22,
          width: 22,
          color:couleur,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

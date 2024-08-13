import 'package:flutter/material.dart';
import 'package:gandalverse/core/themes/color/themeColors.dart';
import 'package:gandalverse/core/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class BtnRoundedIconBack extends StatelessWidget {
  final Function? onpress;
  const BtnRoundedIconBack({super.key, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onpress as void Function()?,
      child: Container(
        decoration: BoxDecoration(
            color: Themecolors.ColorWhite.withOpacity(0.3),
            shape: BoxShape.circle),
        padding: const EdgeInsets.all(12),
        child: CustomImageView(
          imagePath: Images.leftArrow,
          height: 26,
          width: 26,
          color: Themecolors.ColorWhite,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

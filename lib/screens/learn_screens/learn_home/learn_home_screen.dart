import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/rounded_btn_back.dart';
import 'package:gandalverse/screens/new_design_screens/helper/ui_helper.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:go_router/go_router.dart';

class LearnHomeScreen extends StatelessWidget {
  const LearnHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: BtnRoundedIconBack(
                couleur: Themecolors.Color3,
                onpress: () {
                  context.pop();
                },
              ),
            ),
          ),
          Flexible(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: Images.soon,
                height: realH(200),
                width: realW(200),
                fit: BoxFit.contain,
                margin: const EdgeInsets.all(10),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  'Bientôt disponible',
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Themecolors.Color3, fontFamily: "Aller"),
                ),
              ),
            ],
          )),
        ]),
      ),
    );
  }
}

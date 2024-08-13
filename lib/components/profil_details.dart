import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/components/infoItem.dart';
import 'package:gandalverse/core/themes/color/themeColors.dart';
import 'package:gandalverse/core/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/percent_indicator/linear_percent_indicator.dart';
import 'package:gandalverse/widgets/popups/nieauxDetails_alert.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

class ProfilDetails extends StatelessWidget {
  ProfilDetails({super.key, required this.telegram});
  TelegramWebApp telegram;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.chevron_left,
                    color: Themecolors.Color3,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Text(
                    "Neo - Niv 1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Themecolors.Color3.withOpacity(0.9),
                        fontFamily: "Aller",
                        fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.chevron_right,
                    color: Themecolors.Color3,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: LinearPercentIndicator(
              percent: 0.5,
              isRTL: false,
              backgroundColor: Themecolors.Color3.withOpacity(0.2),
              animateFromLastPercent: true,
              restartAnimation: true,
              linearGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepPurple.shade200,
                    Colors.deepPurple.shade300,
                    Colors.deepPurple.shade400,
                    Colors.deepPurple.shade400,
                    Colors.deepPurple.shade500,
                    Colors.deepPurple.shade600,
                    Colors.deepPurple.shade700,
                  ]),
              lineHeight: 20.0,
              barRadius: const Radius.circular(5),
              leading: Padding(
                padding: const EdgeInsets.only(left: 5, right: 2),
                child: Text(
                  "10k",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Themecolors.Color3,
                    fontFamily: "Aller",
                    fontSize: 12,
                  ),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(left: 5, right: 2),
                child: Text(
                  "100k",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.purple.shade400,
                      fontFamily: "Aller",
                      fontSize: 13),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Themecolors.Color3.withOpacity(0.9),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: AutoSizeText(
                      "Partager GandalVerse",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        fontFamily: 'Aller',
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: Icon(
                      Icons.share,
                      color: Themecolors.Color3,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

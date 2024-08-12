import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/components/infoItem.dart';
import 'package:gandalverse/core/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/percent_indicator/linear_percent_indicator.dart';
import 'package:gandalverse/widgets/popups/nieauxDetails_alert.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

class ProfilDetails extends StatelessWidget {
  ProfilDetails({super.key, required this.Color3, required this.telegram});
  TelegramWebApp telegram;
  final Color Color3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
               "UserName",
              //"${telegram.initData.user.firstname ?? ''} ${telegram.initData.user.lastname ?? ''} ",
              maxLines: 1,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 15,
                  color: Color3,
                  fontFamily: "Aller",
                  fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Text(
              "Œuf - Niv 1",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color3.withOpacity(0.9),
                  fontFamily: "Aller",
                  fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: LinearPercentIndicator(
              percent: 0.5,
              isRTL: false,
              backgroundColor: Color3.withOpacity(0.2),
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
                    color: Color3,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: AutoSizeText(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla non tincidunt odio. Nunc id tellus lectus.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Color3.withOpacity(0.95),
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Grade",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Color3,
                      fontFamily: "Aller",
                      fontSize: 12),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: Images.gvt,
                        fit: BoxFit.contain,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 5),
                      AutoSizeText(
                        '20,5K',
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color3,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            elevation: 0.0,
            surfaceTintColor: Colors.transparent,
            color: Color3.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                children: [
                  /* infoItem(
                    titre: "Code de Réference",
                    data: "56884559",
                    showCopy: true,
                    dataColor: Colors.deepPurple.shade400,
                  ),*/
                  infoItem(
                    titre: "Exp Total",
                    data: "200000",
                    showCopy: false,
                    dataColor: Color3,
                  ),
                  infoItem(
                    titre: "Amis invités",
                    data: "0",
                    showCopy: false,
                    dataColor: Color3,
                  ),
                  infoItem(
                    titre: "Mes panneaux",
                    data: "2",
                    showCopy: false,
                    dataColor: Color3,
                  ),
                  infoItem(
                    titre: "Mes Immeubles",
                    data: "0",
                    showCopy: false,
                    dataColor: Color3,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 200,
              child: DefaultButton(
                backColor: Color3.withOpacity(0.9),
                text: ' Détails Niveaux >',
                elevation: 1.0,
                radius: 5,
                textColor: Colors.white,
                fontSize: 12,
                paddingV: 5,
                height: 40,
                press: () {
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (_) => NiveauxDetails_PopUp(),
                  );
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Color3.withOpacity(0.9),
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
                      color: Color3,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

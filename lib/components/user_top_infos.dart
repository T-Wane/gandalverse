import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/components/infoItem.dart';
import 'package:gandalverse/screens/home.page.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/percent_indicator/linear_percent_indicator.dart';

class userTopInfos extends StatelessWidget {
  const userTopInfos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      elevation: 1.2,
      borderOnForeground: true,
      surfaceTintColor: Color3.withOpacity(0.9),
      color: Color3.withOpacity(0.9),
      shadowColor: const Color.fromARGB(255, 151, 116, 211).withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                CardContentBottomSheet.show(context,
                    child: const ProfilDetails(Color3: Color3),
                    image: Images.vr,
                    fit: BoxFit.contain,
                    setCircle: false);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.purple.shade100,
                  ),
                ),
                margin: const EdgeInsets.only(left: 5, right: 2),
                padding: const EdgeInsets.all(5),
                child: const Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "UserName",
                      //"${telegram.initData.user.username ?? ''} ${telegram.initData.user.lastname ?? ''}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Aller",
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "GV Junior >",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.purple.shade100,
                                fontFamily: "Aller",
                                fontSize: 10),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        LinearPercentIndicator(
                          percent: 0.5,
                          backgroundColor:
                              Colors.grey.shade200.withOpacity(0.2),
                          progressColor: Colors.deepPurple.shade400,
                          lineHeight: 5.0,
                          barRadius: const Radius.circular(10),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CustomImageView(
                      imagePath: Images.gvt,
                      fit: BoxFit.contain,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "200K",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white70,
                          fontFamily: "Aller",
                          fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Profit par heure",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white70,
                          fontFamily: "Aller",
                          fontSize: 7),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      CupertinoIcons.info_circle_fill,
                      color: Colors.white60,
                      size: 15,
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.settings,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilDetails extends StatelessWidget {
  const ProfilDetails({
    super.key,
    required this.Color3,
  });

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
              "GV Junior - Niv 1",
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
              widgetIndicator: Text(
                "50%",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color3,
                    fontFamily: "Aller",
                    fontSize: 12),
              ),
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
                      fontSize: 12),
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
          AutoSizeText(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla non tincidunt odio. Nunc id tellus lectus.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Color3.withOpacity(0.95),
                  fontWeight: FontWeight.normal,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Profit par heure",
            style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Color3,
                fontFamily: "Aller",
                fontSize: 12),
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
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
                  infoItem(
                    titre: "Code de Réference",
                    data: "56884559",
                    showCopy: true,
                    dataColor: Colors.deepPurple.shade400,
                  ),
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
                  infoItem(
                    titre: "Mes panneaux",
                    data: "2",
                    showCopy: false,
                    dataColor: Color3,
                  ),
                  infoItem(
                    titre: "",
                    data: "10/10/2021",
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
                backColor: Colors.red.shade400,
                text: 'Supprimer le compte ',
                elevation: 1.0,
                radius: 5,
                textColor: Colors.white,
                fontSize: 12,
                height: 40,
                press: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

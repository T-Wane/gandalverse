import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/core/themes/images/appImages.dart';
import 'package:gandalverse/screens/Annonces/components/_build_daily_days.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/percent_indicator/linear_percent_indicator.dart';

import '../screens/Annonces/components/_build_go_words.dart';
import '../screens/Annonces/components/_build_scanQr_partenaire.dart';
import 'bottomSheet_modal.dart';

class TapToEarnCard extends StatefulWidget {
  static void show(BuildContext context,
          {Key? key,
          required Widget child,
          Color backColor = Colors.white,
          bool isDismissible = true}) =>
      showModalBottomSheet(
        enableDrag: true,
        isScrollControlled: true,
        isDismissible: isDismissible,
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black54,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(15),
            topStart: Radius.circular(15),
          ),
        ),
        builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
                color: Colors.purpleAccent.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.purpleAccent.withOpacity(0.5),
                      offset: const Offset(1, 1),
                      blurRadius: 10,
                      spreadRadius: 4)
                ]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: backColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: TapToEarnCard(
                  key: key,
                  child: child,
                ),
              ),
            ),
          ),
        ),
        //---------------//
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  TapToEarnCard({Key? key, required this.child}) : super(key: key);

  Widget child;

  @override
  State<TapToEarnCard> createState() => _TapToEarnCardState();
}

class _TapToEarnCardState extends State<TapToEarnCard> {
  List<Map<String, dynamic>> getData(BuildContext context) {
    List<Map<String, dynamic>> data = [
      {
        'image': Images.dailyCalendar,
        'titre': 'Daily',
        'isChecked': true,
        'timeRestant': '2h 30m',
        'onTap': () {
          CardContentBottomSheet.show(context,
              child: const ShowGetDailyRewardSheetContent(),
              fit: BoxFit.contain,
              setCircle: false,
              image: Images.dailyCalendar);
        }
      },
      {
        'image': Images.word,
        'titre': 'Go Word',
        'isChecked': false,
        'timeRestant': '1h 15m',
        'onTap': () {
          CardContentBottomSheet.show(context,
              child: showGoWordSheetContent(),
              fit: BoxFit.contain,
              setCircle: false,
              image: Images.word);
        }
      },
      {
        'image': Images.scanQr,
        'titre': 'Scan',
        'isChecked': true,
        'timeRestant': '3h 45m',
        'onTap': () {
          CardContentBottomSheet.show(context,
              child: const ShowScanQrSheetContent(),
              fit: BoxFit.contain,
              setCircle: false,
              image: Images.black_barcodescanner);
        }
      }
    ];

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      /*Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Align(
              alignment: Alignment.centerRight, child: closeIcon(context))),
      */
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Container(
              height: 85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getData(context)
                    .map((e) => Expanded(
                          child: GestureDetector(
                            onTap: e['onTap'] as Function()?,
                            child: AnimatedContainer(
                              margin: const EdgeInsets.all(2),
                              padding: const EdgeInsets.only(top: 2),
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: Colors.purpleAccent.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Color3.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: e['titre'] == 'Scan'
                                              ? CustomImageView(
                                                  imagePath: e['image'],
                                                  fit: BoxFit.contain,
                                                  margin:
                                                      const EdgeInsets.all(2),
                                                  color: Colors.white,
                                                )
                                              : CustomImageView(
                                                  imagePath: e['image'],
                                                  fit: BoxFit.contain,
                                                  margin:
                                                      const EdgeInsets.all(2),
                                                )),
                                      AutoSizeText(
                                        e['titre'],
                                        presetFontSizes: const [12, 11, 10, 9],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "Aller"),
                                      ),
                                      AutoSizeText(
                                        e['timeRestant'],
                                        presetFontSizes: const [10, 9],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w200,
                                            fontFamily: "Aller"),
                                      ),
                                    ],
                                  ),
                                ), //########################//
                                if (e["isChecked"] == true) ...[
                                  Positioned(
                                    top: 2,
                                    right: 2,
                                    child: Icon(
                                      CupertinoIcons.checkmark_seal_fill,
                                      color: Colors.green.shade400,
                                      size: 12,
                                    ),
                                  )
                                ]
                              ]),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: Images.gvt,
                    fit: BoxFit.contain,
                    height: 35,
                    width: 35,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const AutoSizeText(
                    '100 500 000',
                    maxLines: 1,
                    presetFontSizes: [25, 22, 20, 18, 15, 14],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Aller",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Flexible(child: widget.child),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 5, bottom: 2),
                  child: Text(
                    "1500 Pts",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 11),
                  ),
                ),
                LinearPercentIndicator(
                  percent: 0.5,
                  isRTL: false,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  animateFromLastPercent: true,
                  restartAnimation: true,
                  padding: const EdgeInsets.all(0),
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
                  lineHeight: 15.0,
                  barRadius: const Radius.circular(5),
                ),
              ],
            ),
          ),
          Row(children: [
            CustomImageView(
              imagePath: Images.gvt,
              fit: BoxFit.contain,
              height: 25,
              width: 25,
            ),
            const SizedBox(
              width: 5,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                " +1 ",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                    fontFamily: "Aller",
                    fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                "Gain par clic",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                    fontFamily: "Aller",
                    fontSize: 7),
              ),
            ]),
          ]),
        ]),
      ),
    ]);
  }
}

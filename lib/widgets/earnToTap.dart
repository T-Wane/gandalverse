import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/core/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/percent_indicator/linear_percent_indicator.dart';

import 'bottomSheet_modal.dart';

class TapToEarnCard extends StatelessWidget {
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(15),
            topStart: Radius.circular(15),
          ),
        ),
        builder: (context) => AnimatedContainer(
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
        //---------------//
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  TapToEarnCard({Key? key, required this.child}) : super(key: key);

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      /*Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Align(
              alignment: Alignment.centerRight, child: closeIcon(context))),
      */
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Expanded(
                    child: AnimatedContainer(
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.only(top: 2),
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color3.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
      Flexible(child: child),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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

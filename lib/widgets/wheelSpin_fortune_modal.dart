import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/core/providers/charge_provider.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/core/repositories/spinRewardRepository.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/screens/defis/components/_build_daily_days.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../screens/defis/components/_build_go_words.dart';
import '../screens/defis/components/_build_scanQr_partenaire.dart';
import 'bottomSheet_modal.dart';

class WheelspinFortuneModal extends StatefulWidget {
  static void show(BuildContext context,
          {Key? key,
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
                child: WheelspinFortuneModal(
                  key: key,
                ),
              ),
            ),
          ),
        ),
        //---------------//
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  WheelspinFortuneModal({Key? key}) : super(key: key);

  @override
  State<WheelspinFortuneModal> createState() => _WheelspinFortuneModalState();
}

class _WheelspinFortuneModalState extends State<WheelspinFortuneModal> {
  UserProvider _userProvider = getIt<UserProvider>();
  SpinRewardManager _spinRewardManager = getIt<SpinRewardManager>();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            //Spin
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: Images.coin_dollar,
                    fit: BoxFit.contain,
                    height: 35,
                    width: 35,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  AutoSizeText(
                    "${context.watch<UserProvider>().user?.coins ?? 0}",
                    maxLines: 1,
                    presetFontSizes: const [25, 22, 20, 18, 15, 14],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
      Flexible(child: ),
      // earnToTapBottomWidget(),
    ]);
  }
}
/*
class earnToTapBottomWidget extends StatelessWidget {
  const earnToTapBottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ChargeManager>(builder: (context, chargeManager, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 2),
                  child: Text(
                    "${chargeManager.points} Pts",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 11),
                  ),
                ),
                LinearPercentIndicator(
                  percent: chargeManager.points / chargeManager.maxPoints,
                  isRTL: false,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  animateFromLastPercent: true,
                  restartAnimation: true,
                  padding: const EdgeInsets.all(0),
                  linearGradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: chargeManager.getGradient()
                      /*[
                        Colors.deepPurple.shade200,
                        Colors.deepPurple.shade300,
                        Colors.deepPurple.shade400,
                        Colors.deepPurple.shade400,
                        Colors.deepPurple.shade500,
                        Colors.deepPurple.shade600,
                        Colors.deepPurple.shade700,
                      ]*/
                      ),
                  lineHeight: 15.0,
                  barRadius: const Radius.circular(5),
                ),
              ],
            ),
          ),
          Row(children: [
            CustomImageView(
              imagePath: Images.coin_dollar,
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
      );
    });
  }
}
*/
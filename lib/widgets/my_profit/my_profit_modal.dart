import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/core/repositories/spinRewardRepository.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_modal.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/my_profit/my_profit_widget.dart';
import 'package:gandalverse/widgets/reward/reward_animation.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

class MyProfitModal extends StatefulWidget {
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
        builder: (context) => PointerInterceptor(
          child: BackdropFilter(
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
                  child: MyProfitModal(
                    key: key,
                  ),
                ),
              ),
            ),
          ),
        ),
        //---------------//
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  MyProfitModal({Key? key}) : super(key: key);

  @override
  State<MyProfitModal> createState() => _MyProfitModalState();
}

class _MyProfitModalState extends State<MyProfitModal> {
  UserProvider _userProvider = getIt<UserProvider>();
  SpinRewardManager _spinRewardManager = getIt<SpinRewardManager>();

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      debug: false,
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Align(alignment: Alignment.centerRight, child: closeIcon(context)),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: AutoSizeText(
            'JackPot'.toUpperCase(),
            maxLines: 1,
            minFontSize: 20,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, color: Themecolors.Color3, fontFamily: "Aller"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: AutoSizeText(
            'Gandalverse vous offre un JackPot de 15.000 coins',
            maxLines: 2,
            minFontSize: 17,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Themecolors.Color3, fontFamily: "Aller"),
          ),
        ),
        CustomImageView(
          imagePath: Images.gold,
          height: 150,
          width: 150,
          fit: BoxFit.contain,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CustomImageView(
              //   imagePath: Images.coin_dollar,
              //   fit: BoxFit.contain,
              //   height: 30,
              //   width: 30,
              // ),
              // const SizedBox(width: 5),
              AutoSizeText(
                "15 000",
                maxLines: 1,
                presetFontSizes: const [22, 20, 18, 15, 14],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Themecolors.Color3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        MyProfitWidget(
            boutonStyle: true,
            claimed: () {
            //  RewardAnimation.show(context);
              _spinRewardManager.claimReward().whenComplete(() {
                // Future.delayed(Duration(seconds: 3), () {
                //   RewardAnimation.hide(context);
                // });
              });
            })
      ]),
    );
  }
}

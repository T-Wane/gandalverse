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
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

import 'wheel.dart';

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
                  child: WheelspinFortuneModal(
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
      Align(alignment: Alignment.centerRight, child: closeIcon(context)),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: AutoSizeText(
          'Roue de la Fortune',
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
          'Tournez la roue pour gagner des jetons',
          maxLines: 2,
          minFontSize: 17,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: Themecolors.Color3, fontFamily: "Aller"),
        ),
      ),
      Flexible(child: FortuneWheelWidget()),
    ]);
  }
}

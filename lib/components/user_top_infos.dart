import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/components/infoItem.dart';
import 'package:gandalverse/core/data/levels.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/core/route/route_name.dart';
import 'package:gandalverse/screens/home.page.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/screens/profil/profil_screen.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/percent_indicator/linear_percent_indicator.dart';
import 'package:gandalverse/widgets/profilDetails_bottomSheet.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

import 'package:telegram_web_app/telegram_web_app.dart';

import 'profil_details.dart';

class userTopInfos extends StatefulWidget {
  userTopInfos(
      {super.key,
      this.goBack,
      this.changeVisibility,
      this.showBackArrow = false,
      this.showVisibleEye = false});

  VoidCallback? goBack;
  bool showBackArrow;
  bool showVisibleEye;
  VoidCallback? changeVisibility;

  @override
  State<userTopInfos> createState() => _userTopInfosState();
}

class _userTopInfosState extends State<userTopInfos> {
  final TelegramWebApp telegram = TelegramWebApp.instance;

  bool? isDefinedVersion;
  String? clipboardText;

  @override
  void initState() {
    super.initState();

    FlutterError.onError = (details) {
      //showSnackbar("Flutter error: $details");
      print("Flutter error happened: $details");
    };

    //TelegramWebApp.instance.ready();
    check();
  }

  void check() async {
    await Future.delayed(const Duration(seconds: 2));
    // isDefinedVersion = await telegram.isVersionAtLeast('Bot API 6.1');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, _userProvider, child) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        elevation: 1.2,
        borderOnForeground: true,
        surfaceTintColor: Color3.withOpacity(0.9),
        color: Color3.withOpacity(0.9),
        shadowColor: const Color.fromARGB(255, 151, 116, 211).withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          height: 50,
          child: PointerInterceptor(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.showBackArrow) ...[
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white10,
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.only(left: 5, right: 2),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                  const Spacer(),
                ] else ...[
                  GestureDetector(
                    onTap: () {
                      // CardContentBottomSheet.show(context,
                      //     child: ProfilDetails(telegram: telegram),
                      //     image: Images.niveau1,
                      //     fit: BoxFit.contain,
                      //     setCircle: true);

                      // ProfilDetailsContentBottomSheet.show(context,
                      //     telegram: telegram);
                      context.pushNamed(profil_view);
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
                      padding: const EdgeInsets.all(2),
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
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              //  "UserName",
                              "${telegram.initData.user.firstname ?? ''} ${telegram.initData.user.lastname ?? ''} ",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "Aller",
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                  "${_userProvider.getUserLevelDetails()?['title']??'---'}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.purple.shade100,
                                        fontFamily: "Aller",
                                        fontSize: 10),
                                  ),
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                UserLevelProgress(userLevelIndex: _userProvider.user?.level??1, userCoins: _userProvider.user?.coins??0)
                                // LinearPercentIndicator(
                                //   percent: 0.5,
                                //   backgroundColor:
                                //       Colors.grey.shade200.withOpacity(0.2),
                                //   progressColor: Colors.deepPurple.shade400,
                                //   lineHeight: 5.0,
                                //   barRadius: const Radius.circular(10),
                                // ),
                              ],
                            ),
                          )
                        ]),
                  ),
                ],
                const SizedBox(
                  width: 2,
                ),
                if (widget.showVisibleEye) ...[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.showVisibleEye = !widget.showVisibleEye;
                        widget.changeVisibility?.call();
                      });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white10),
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        widget.showVisibleEye
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
                const SizedBox(
                  width: 5,
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
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _userProvider.user?.gradleFormate ?? '00',
                          style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white70,
                              fontFamily: "Aller",
                              fontSize: 12),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Grade",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white70,
                              fontFamily: "Aller",
                              fontSize: 7),
                        ),
                      ]),
                ]),
                PointerInterceptor(
                  // debug: true,
                  child: _setting(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _setting() => Padding(
        padding: const EdgeInsets.only(left: 2, right: 5),
        child: PopupMenuButton<int>(
          icon: const Icon(
            CupertinoIcons.gear,
            color: Colors.white,
            size: 20,
          ),

          itemBuilder: (context) => [
            PopupMenuItem(
                value: 1,
                child: PointerInterceptor(
                    child: _actionList(CupertinoIcons.refresh, "Rafraîchir"))),
            PopupMenuItem(
              value: 2,
              child: PointerInterceptor(
                child: _actionList(CupertinoIcons.shield_lefthalf_fill,
                    "Politique de confidentialité"),
              ),
            ),
            PopupMenuItem(
              value: 3,
              child: PointerInterceptor(
                child: _actionList(CupertinoIcons.power, "Quitter"),
              ),
            ),
          ],
          offset: const Offset(0, 40),
          color: const Color.fromARGB(255, 18, 54, 96),
          elevation: 2,
          // on selected we show the dialog box
          onSelected: (value) {
            if (value == 1) {
            } else if (value == 2) {
            } else if (value == 3) {}
          },
        ),
      );

// custom action widget
  Widget _actionList(IconData icon, String text) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          maxLines: 1,
          textAlign: TextAlign.right,
          style: const TextStyle(
              fontSize: 15, fontFamily: 'Aller', color: Colors.white),
        )
      ],
    );
  }
}


class UserLevelProgress extends StatefulWidget {
  final int userLevelIndex; // Niveau actuel de l'utilisateur
  final int userCoins; // Coins de l'utilisateur

  UserLevelProgress({required this.userLevelIndex, required this.userCoins});

  @override
  State<UserLevelProgress> createState() => _UserLevelProgressState();
}

class _UserLevelProgressState extends State<UserLevelProgress> {
  @override
  Widget build(BuildContext context) {
    final currentLevelDetails = levels.values
        .firstWhere((level) => level['index'] == widget.userLevelIndex, orElse: () => {});
    
    if (currentLevelDetails.isEmpty) {
      return SizedBox.shrink(); // Retourne une taille nulle si le niveau actuel n'est pas trouvé
    }

    final currentLevelCoinsRequired = currentLevelDetails['coins_required'] as int;

    Map<String, dynamic> nextLevelDetails = {};
    for (final level in levels.values) {
      if (level['index'] == widget.userLevelIndex + 1) {
        nextLevelDetails = level;
        break;
      }
    }

    final nextLevelCoinsRequired = nextLevelDetails.isNotEmpty
        ? nextLevelDetails['coins_required'] as int
        : currentLevelCoinsRequired;

    final progress = (widget.userCoins - currentLevelCoinsRequired).clamp(0, nextLevelCoinsRequired) /
        (nextLevelCoinsRequired - currentLevelCoinsRequired);
        print("widget.userCoins : $widget.userCoins");
        print("currentLevelCoinsRequired : $currentLevelCoinsRequired");
        print("calim ${(widget.userCoins - currentLevelCoinsRequired).clamp(0, nextLevelCoinsRequired)} / ${(nextLevelCoinsRequired - currentLevelCoinsRequired)}");
    print("progress : $progress");
    return LinearPercentIndicator(
      percent: progress,
      backgroundColor: Colors.grey.shade200.withOpacity(0.2),
      progressColor: Colors.deepPurple.shade400,
      lineHeight: 5.0,
      barRadius: const Radius.circular(10),
    );
  }
}

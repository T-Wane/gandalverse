import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/screens/amis/components/bottom_invite_btns.dart';
import 'package:gandalverse/screens/defis/components/annonceCard.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/reward/reward_animation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuildInviterFirends extends StatefulWidget {
  const BuildInviterFirends({
    super.key,
  });

  @override
  State<BuildInviterFirends> createState() => _BuildInviterFirendsState();
}

class _BuildInviterFirendsState extends State<BuildInviterFirends> {
  String task_inviterThreeFriendsKey = "task_inviter_3_amis_KEY";

  late SharedPreferences prefs;

  void claimed() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool(task_inviterThreeFriendsKey, true);
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  bool isClaimed() {
    return prefs.getBool(task_inviterThreeFriendsKey) ?? false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget _buildClaimedBtn(int nFriends, UserProvider userProvider) {
    if (nFriends >= 3 && !isClaimed()) {
      return DefaultButton(
        backColor: Colors.purple.shade300,
        text: 'Recupérer',
        elevation: 1.0,
        textColor: Colors.white,
        fontSize: 13,
        height: 40,
        press: () {
          RewardAnimation.show(context);
          claimed();
          if (userProvider.user != null) {
            final updatedUser = userProvider.user!.rebuild(
                (b) => b..coins = ((userProvider.user?.coins ?? 0) + 30000));
            userProvider.updateUserPointLocal(updatedUser);
          }
          Future.delayed(const Duration(seconds: 3), () {
            RewardAnimation.hide(context);
          });
          Navigator.of(context).pop();
        },
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, _userProvider, child) {
      return AnnonceCard(
          title: 'Invites 3 Amis',
          text: '',
          reward: "30 000",
          imagePath: Images.invites3Amis,
          isComplete: isClaimed(),
          backColors: const [
            Colors.white,
            Colors.white,
          ],
          fit: BoxFit.contain,
          press: () {
            CardContentBottomSheet.show(context,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Inviter vos amis",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            color: Themecolors.Color3,
                            fontFamily: "Aller",
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AutoSizeText(
                        'Invitez 3 amis et obtenez un bonus exceptionnel !',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Themecolors.Color3.withOpacity(0.95),
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: Images.coin_dollar,
                            fit: BoxFit.contain,
                            height: 40,
                            width: 40,
                          ),
                          AutoSizeText(
                            '20 000',
                            maxLines: 1,
                            presetFontSizes: [22, 20, 18, 15, 14],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Themecolors.Color3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      _buildClaimedBtn(
                          _userProvider.friends.length, _userProvider),
                      const SizedBox(
                        height: 5,
                      ),
                      const bottomInviteBtns(),
                    ],
                  ),
                ),
                fit: BoxFit.contain,
                image: Images.invites3Amis);
          },
          textColor: Colors.black,
          titleColor: Themecolors.Color3);
    });
  }
}

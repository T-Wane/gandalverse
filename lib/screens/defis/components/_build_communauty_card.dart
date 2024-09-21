import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/core/modeles/social_link/social_link.dart';
import 'package:gandalverse/core/repositories/social_link_repo/social_linkRespository.dart';
import 'package:gandalverse/data/telegram_client.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/screens/defis/components/annonceCard.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/countTime/claim_link_coins.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/reward/reward_animation.dart';

class buildCommunautyCard extends StatefulWidget {
  buildCommunautyCard(
      {super.key, required this.socialLinkModel, required this.refresh});

  SocialLinkModel socialLinkModel;
  Function() refresh;
  @override
  State<buildCommunautyCard> createState() => _buildCommunautyCardState();
}

class _buildCommunautyCardState extends State<buildCommunautyCard>
    with WidgetsBindingObserver {
  TelegramClient _telegramClient = getIt<TelegramClient>();

  SocialLinkService _linkService = getIt<SocialLinkService>();
  bool _showAnimation = false; // Variable pour déclencher l'animation

  @override
  void initState() {
    super.initState();
    // Observer le cycle de vie de l'application
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Ne pas oublier de retirer l'observer pour éviter les fuites de mémoire
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Lorsque l'application revient au premier plan
      RewardAnimation.show(context);
      Future.delayed(const Duration(seconds: 3), () {
        RewardAnimation.hide(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnonceCard(
        title: widget.socialLinkModel.description,
        text: '', //widget.socialLinkModel.description,
        reward: " ${widget.socialLinkModel.reward}",
        imagePath: widget.socialLinkModel.image,
        backColors: const [
          Colors.white,
          Colors.white,
        ],
        fit: BoxFit.contain,
        isComplete: widget.socialLinkModel.isClaimed ?? false,
        press: () {
          CardContentBottomSheet.show(context,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.socialLinkModel.title,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          color: Themecolors.Color3.withOpacity(0.9),
                          fontFamily: "Aller",
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      widget.socialLinkModel.description,
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
                          "${widget.socialLinkModel.reward}",
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
                    ClaimLinkCoins_btn(
                      socialLinkModel: widget.socialLinkModel,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DefaultButton(
                      backColor: Colors.purple.shade400,
                      text: 'Rejoindre',
                      elevation: 1.0,
                      textColor: Colors.white,
                      fontSize: 15,
                      height: 50,
                      press: () async {
                        /*if (widget.socialLinkModel.subscriptionLink.trim() !=
                                '' ||
                            !widget.socialLinkModel.isSubscribed) {*/
                        widget.refresh();
                        Navigator.of(context).pop();
                        _linkService.openLinkAndUpdateStatus(
                            widget.socialLinkModel.id,
                            widget.socialLinkModel.subscriptionLink);
                        setState(() {});
                        //   }
                      },
                    )
                  ],
                ),
              ),
              image: widget.socialLinkModel.image);
        },
        textColor: Colors.black,
        titleColor: Themecolors.Color3);
  }
}

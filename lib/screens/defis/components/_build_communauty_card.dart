import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/core/modeles/social_link/social_link.dart';
import 'package:gandalverse/screens/defis/components/annonceCard.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class buildCommunautyCard extends StatelessWidget {
  buildCommunautyCard({super.key, required this.socialLinkModel});

  SocialLinkModel socialLinkModel;

  @override
  Widget build(BuildContext context) {
    return AnnonceCard(
        // title: 'Facebook',
        text: socialLinkModel.description,
        reward: "${socialLinkModel.reward}",
        imagePath: socialLinkModel.image,
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
                      socialLinkModel.title,
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
                      socialLinkModel.description,
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
                          "${socialLinkModel.reward}",
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
                    DefaultButton(
                      backColor: socialLinkModel.subscriptionLink.trim() == ''
                          ? Colors.grey.shade300
                          : Colors.purple.shade400,
                      text: 'Rejoindre',
                      elevation: 1.0,
                      textColor: socialLinkModel.subscriptionLink.trim() == ''
                          ? Colors.grey.shade800
                          : Colors.white,
                      fontSize: 15,
                      height: 50,
                      press: () {
                        if (socialLinkModel.subscriptionLink.trim() == '') {
                          socialLinkModel.openLink();
                        }
                      },
                    )
                  ],
                ),
              ),
              image: socialLinkModel.image);
        },
        textColor: Colors.black,
        titleColor: Themecolors.Color3);
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/screens/amis/components/bottom_invite_btns.dart';
import 'package:gandalverse/screens/defis/components/annonceCard.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class BuildInviterFirends extends StatelessWidget {
  const BuildInviterFirends({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnnonceCard(
        // title: 'Youtube',
        text: 'Inviter 3 Amis \n',
        reward: "20 000",
        imagePath: Images.add_friends,
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
                    DefaultButton(
                      backColor: Colors.grey.shade300,
                      text: 'Vérifier',
                      elevation: 1.0,
                      textColor: Colors.grey.shade800,
                      fontSize: 13,
                      height: 40,
                      press: () {},
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const bottomInviteBtns(),
                  ],
                ),
              ),
              image: Images.add_friends);
        },
        textColor: Colors.black,
        titleColor: Themecolors.Color3);
  }
}

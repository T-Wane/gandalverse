import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/screens/amis/components/elementCard.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class inviterAmiCard extends StatelessWidget {
  inviterAmiCard({
    super.key,
    required this.Color3,
  });

  final Color Color3;

  UserProvider _userProvider = getIt<UserProvider>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _userProvider.inviterAmi(),
      child: ElementCard(
          title: 'Inviter un ami',
          leadingWidget: CustomImageView(
            imagePath: "assets/images/gift.png",
            height: 55,
            width: 55,
            fit: BoxFit.contain,
          ),
          SubWidget: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: Images.coin_dollar,
                        fit: BoxFit.contain,
                        height: 23,
                        width: 23,
                      ),
                      AutoSizeText(
                        '+10000',
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.yellow.shade600,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        ' pour vous et votre ami',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Color3.withOpacity(0.7),
                            fontFamily: "Aller"),
                      )
                    ],
                  ),
                )
              ],
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Color3, fontFamily: "Aller"),
            ),
          ),
          backColors: const [
            Colors.white,
            Colors.white,
          ],
          press: () {},
          titleColor: Color3),
    );
  }
}

class inviterAmiWithPremiumCard extends StatelessWidget {
  const inviterAmiWithPremiumCard({
    super.key,
    required this.Color3,
  });

  final Color Color3;

  @override
  Widget build(BuildContext context) {
    return ElementCard(
        title: 'Les Piliers',
        leadingWidget: CustomImageView(
          imagePath: Images.group,
          height: 55,
          width: 55,
          fit: BoxFit.contain,
        ),
        SubWidget: Text.rich(
          TextSpan(
            text: 'Les plus influents de la communauté! ', // Texte normal
            style: TextStyle(
              color: Color3.withOpacity(0.7),
              fontSize: 12,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '[ comming soon ]', // Texte en gras
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Appliquer le gras ici
                  color: Color3.withOpacity(0.7),
                ),
              ),
            ],
          ),
          textAlign: TextAlign.start,
        ),
        backColors: const [
          Colors.white,
          Colors.white,
        ],
        press: () {},
        titleColor: Color3);
  }
}

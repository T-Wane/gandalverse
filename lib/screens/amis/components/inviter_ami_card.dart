import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/screens/amis/components/elementCard.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class inviterAmiCard extends StatelessWidget {
  const inviterAmiCard({
    super.key,
    required this.Color3,
  });

  final Color Color3;

  @override
  Widget build(BuildContext context) {
    return ElementCard(
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
                      imagePath: Images.gvt,
                      fit: BoxFit.contain,
                      height: 23,
                      width: 23,
                    ),
                    AutoSizeText(
                      '+7500',
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.yellow.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      ' pour vous et votre ami',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Color3.withOpacity(0.7), fontFamily: "Aller"),
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
        titleColor: Color3);
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
        title: 'GVT Communauté',
        leadingWidget: CustomImageView(
          imagePath: Images.group,
          height: 55,
          width: 55,
          fit: BoxFit.contain,
        ),
        SubWidget: Text(
          'Voir vos influenceurs ou gagner grâce à vos atistes préférés',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Color3.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
        backColors: const [
          Colors.white,
          Colors.white,
        ],
        press: () {},
        titleColor: Color3);
  }
}

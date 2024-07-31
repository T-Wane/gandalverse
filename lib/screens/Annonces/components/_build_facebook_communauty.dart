import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/screens/Annonces/components/annonceCard.dart';
import 'package:gandalverse/core/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class buildFacebookCommunauty extends StatelessWidget {
  const buildFacebookCommunauty({
    super.key,
    required this.Color3,
  });

  final Color Color3;

  @override
  Widget build(BuildContext context) {
    return AnnonceCard(
        title: 'Facebook',
        text: 'Rejoindre notre communauté Facebook',
        imagePath: Images.black_facebook,
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
                      "Communauté Facebook",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          color: Color3,
                          fontFamily: "Aller",
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla non tincidunt odio. Nunc id tellus lectus.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Color3.withOpacity(0.95),
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
                          imagePath: Images.gvt,
                          fit: BoxFit.contain,
                          height: 40,
                          width: 40,
                        ),
                        AutoSizeText(
                          '205 000',
                          maxLines: 1,
                          presetFontSizes: [22, 20, 18, 15, 14],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                      press: () {},
                    )
                  ],
                ),
              ),
              image: Images.black_facebook);
        },
        textColor: Colors.black,
        titleColor: Color3);
  }
}

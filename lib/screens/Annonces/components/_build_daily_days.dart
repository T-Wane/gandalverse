import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/screens/Annonces/components/annonceCard.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class buildDailyDays extends StatelessWidget {
  const buildDailyDays({
    super.key,
    required this.Color3,
  });

  final Color Color3;

  @override
  Widget build(BuildContext context) {
    return AnnonceCard(
        title: 'Daily',
        text: 'Récupérer votre récompense quotidienne',
        imagePath: Images.dailyCalendar,
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
                      "Récompense du Jour",
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
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Color3.withOpacity(0.95),
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: List.generate(7, (index) {
                        return Container(
                          width: 80,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color3.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1, color: Colors.purple.shade100)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Jour ${index + 1}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/coin.png",
                                    fit: BoxFit.contain,
                                    height: 25,
                                    width: 25,
                                  ),
                                  const Text(
                                    "200K",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white70,
                                        fontFamily: "Aller",
                                        fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DefaultButton(
                      backColor: Colors.purple.shade400,
                      text: 'Reclammer',
                      elevation: 1.0,
                      textColor: Colors.white,
                      fontSize: 15,
                      height: 50,
                      press: () {},
                    )
                  ],
                ),
              ),
              fit: BoxFit.contain,
              setCircle: false,
              image: Images.dailyCalendar);
        },
        textColor: Colors.black,
        titleColor: Color3);
  }
}

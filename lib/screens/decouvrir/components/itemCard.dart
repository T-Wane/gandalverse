import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class itemCard extends StatelessWidget {
  itemCard({
    super.key,
  });
  Color Color3 = Color.fromARGB(255, 18, 40, 70);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CardContentBottomSheet.show(context,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "titre de la carte",
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
                  Text(
                    "Profit par heure",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Color3,
                        fontFamily: "Aller",
                        fontSize: 12),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: "assets/images/coin.png",
                        fit: BoxFit.contain,
                        height: 20,
                        width: 20,
                      ),
                      AutoSizeText(
                        '20,5K',
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color3,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: "assets/images/coin.png",
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
                    text: 'Go',
                    elevation: 1.0,
                    textColor: Colors.white,
                    fontSize: 15,
                    height: 50,
                  )
                ],
              ),
            ),
            titre: 'Nos Annonces');
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(207, 18, 40, 70),
              Color.fromARGB(219, 18, 40, 70),
              Color.fromARGB(234, 18, 40, 70),
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(children: [
          Stack(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black87,
                  image: const DecorationImage(
                    image: AssetImage("assets/images/img_back1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.deepPurple.shade400,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: "assets/images/coin.png",
                            fit: BoxFit.contain,
                            height: 20,
                            width: 20,
                          ),
                          const AutoSizeText(
                            '20,5K',
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Profit par heure",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white70,
                            fontFamily: "Aller",
                            fontSize: 7),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
              margin: const EdgeInsets.only(top: 0),
              width: double.infinity,
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 2,
                vertical: 2,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      'Nom de la carte',
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    AutoSizeText(
                      'Decriprion de la carte',
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.white70,
                            fontWeight: FontWeight.w200,
                          ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: Colors.white38,
                        thickness: 0.1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AutoSizeText(
                          'Niv 1',
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                        const VerticalDivider(
                          color: Colors.white54,
                          width: 0.4,
                          thickness: 0.1,
                        ),
                        Row(
                          children: [
                            CustomImageView(
                              imagePath: "assets/images/coin.png",
                              fit: BoxFit.contain,
                              height: 20,
                              width: 20,
                            ),
                            AutoSizeText(
                              '20,5K',
                              maxLines: 1,
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
              /*GestureDetector(
                  onTap:
                      () /* => showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (_) => BadgeAddedAlert(),
                            )*/
                      {},
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 22,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),*/
              ),
        ]),
      ),
    );
  }
}

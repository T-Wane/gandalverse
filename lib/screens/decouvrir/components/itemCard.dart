import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class itemCard extends StatelessWidget {
  itemCard({
    super.key,
  });
  Color Color3 = Color.fromARGB(255, 18, 40, 70);
  @override
  Widget build(BuildContext context) {
    return Container(
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
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
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
                  /*const AutoSizeText(
                    "Nom de la carte",
                    presetFontSizes: [11],
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Aller',
                    ),
                  ),*/
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
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Colors.white70,
                              fontWeight: FontWeight.w200,
                            ),
                      ),
                      const VerticalDivider(
                        color: Colors.white54,
                        width: 0.4,thickness: 0.1,
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
    );
  }
}

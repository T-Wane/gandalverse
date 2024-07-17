import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

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
        Expanded(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black87,
                  image: DecorationImage(
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
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green.shade400,
                  ),
                  child: const AutoSizeText(
                    'Active',
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 0),
            width: double.infinity,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 2,
              vertical: 2,
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "Nom de l'entriprise ou titre de l'exposition",
                    presetFontSizes: [13, 12],
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Aller',
                    ),
                  ),
                  AutoSizeText(
                    'Cliquer pour visualiser',
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                    ),
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

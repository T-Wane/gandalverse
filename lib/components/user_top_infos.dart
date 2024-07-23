import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/screens/home.page.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/percent_indicator/linear_percent_indicator.dart';

class userTopInfos extends StatelessWidget {
  const userTopInfos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 1.2,
      borderOnForeground: true,
      surfaceTintColor: Color3.withOpacity(0.9),
      color: Color3.withOpacity(0.9),
      shadowColor:
          const Color.fromARGB(255, 151, 116, 211).withOpacity(0.5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Colors.purple.shade100,
                ),
              ),
              margin: const EdgeInsets.only(left: 5, right: 2),
              padding: const EdgeInsets.all(5),
              child: const Icon(
                CupertinoIcons.person,
                color: Colors.white,
                size: 25,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "UserName",
                      // "${telegram.initData.user.username ?? ''} ${telegram.initData.user.lastname ?? ''}",
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                            fontFamily: "Aller",
                            fontSize: 14,
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "GV Junior >",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.purple.shade100,
                                fontFamily: "Aller",
                                fontSize: 10),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        LinearPercentIndicator(
                          percent: 0.5,
                          backgroundColor:
                              Colors.grey.shade200.withOpacity(0.2),
                          progressColor: Colors.deepPurple.shade400,
                          lineHeight: 5.0,
                          barRadius: const Radius.circular(10),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "Profit par heure",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white70,
                          fontFamily: "Aller",
                          fontSize: 8),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      CupertinoIcons.info_circle_fill,
                      color: Colors.white60,
                      size: 15,
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: "assets/images/coin.png",
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
            )
          ],
        ),
      ),
    );
  }
}

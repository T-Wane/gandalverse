import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/core/repositories/dailyRewardRepository.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/screens/defis/components/annonceCard.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/reward/reward_animation.dart';

class buildDailyDays extends StatefulWidget {
  const buildDailyDays({
    super.key,
    required this.Color3,
  });

  final Color Color3;

  @override
  State<buildDailyDays> createState() => _buildDailyDaysState();
}

class _buildDailyDaysState extends State<buildDailyDays> {
  bool isClaimed = false;

  final DailyRewardManager dailyManager = getIt<DailyRewardManager>();

  @override
  void initState() {
    super.initState();
    updateDailyReward();
  }

  // Fonction pour mettre à jour la récompense quotidienne
  Future<void> updateDailyReward() async {
    isClaimed = await dailyManager.isRewardClaimed();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnnonceCard(
        title: 'Daily',
        text: 'Récupérer votre récompense quotidienne',
        imagePath: Images.dailyCalendar,
        isComplete: isClaimed,
        backColors: const [
          Colors.white,
          Colors.white,
        ],
        fit: BoxFit.contain,
        press: () {
          CardContentBottomSheet.show(context,
              child: const ShowGetDailyRewardSheetContent(),
              fit: BoxFit.contain,
              setCircle: false,
              image: Images.dailyCalendar);
        },
        textColor: Colors.black,
        titleColor: widget.Color3);
  }
}

class ShowGetDailyRewardSheetContent extends StatefulWidget {
  const ShowGetDailyRewardSheetContent({
    super.key,
  });

  @override
  State<ShowGetDailyRewardSheetContent> createState() =>
      _ShowGetDailyRewardSheetContentState();
}

class _ShowGetDailyRewardSheetContentState
    extends State<ShowGetDailyRewardSheetContent> {
  int currentDay = 1;

  int coinsReward = 0;

  bool isClaimed = false;

  final DailyRewardManager dailyManager = getIt<DailyRewardManager>();

  @override
  void initState() {
    super.initState();
    updateDailyReward();
  }

  // Fonction pour mettre à jour la récompense quotidienne
  Future<void> updateDailyReward() async {
    currentDay = await dailyManager.getCurrentDay();
    coinsReward = await dailyManager.getRewardForToday();
    isClaimed = await dailyManager.isRewardClaimed();
    RewardAnimation.show(context);
    Future.delayed(const Duration(seconds: 3), () {
      RewardAnimation.hide(context);
    });
    setState(() {});
  }

  void claimReward() async {
    await dailyManager.claimReward();
    updateDailyReward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                color: Themecolors.Color3,
                fontFamily: "Aller",
                fontWeight: FontWeight.normal),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: AutoSizeText(
              'Récupérer votre récompence journalière',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Themecolors.Color3.withOpacity(0.95),
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: List.generate(dailyManager.dailyCoins.length, (index) {
              return Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                    color: (index == (currentDay - 1) && !isClaimed)
                        ? Colors.yellow.shade300
                        : (index < (currentDay))
                            ? Colors.green.shade300
                            : Themecolors.Color3.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1,
                        color: (index == (currentDay - 1) && !isClaimed)
                            ? Colors.yellow.shade500
                            : Colors.purple.shade100)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Jour ${index + 1}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.coin_dollar,
                          fit: BoxFit.contain,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 2.0),
                        Text(
                          "${dailyManager.dailyCoins[index]}",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: index == 0 ? Colors.white : Colors.white70,
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
            backColor:
                isClaimed ? Colors.grey.shade300 : Colors.purple.shade400,
            text: 'Reclammer',
            elevation: 1.0,
            textColor: isClaimed ? Colors.grey.shade600 : Colors.white,
            fontSize: 15,
            height: 50,
            press: () {
              claimReward();
            },
          )
        ],
      ),
    );
  }
}

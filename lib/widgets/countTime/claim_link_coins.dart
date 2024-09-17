import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/core/modeles/social_link/social_link.dart';
import 'package:gandalverse/core/repositories/dailyRewardRepository.dart';
import 'package:gandalverse/core/repositories/social_link_repo/social_linkRespository.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/widgets/reward/reward_animation.dart';

class ClaimLinkCoins_btn extends StatefulWidget {
  final SocialLinkModel socialLinkModel;

  const ClaimLinkCoins_btn({required this.socialLinkModel, Key? key})
      : super(key: key);

  @override
  _ClaimLinkCoins_btnState createState() => _ClaimLinkCoins_btnState();
}

class _ClaimLinkCoins_btnState extends State<ClaimLinkCoins_btn> {
  SocialLinkService _linkService = getIt<SocialLinkService>();
  late Timer _timer;
  Map<String, int> _timeRemaining = {'hours': 0, 'minutes': 0, 'seconds': 0};

  @override
  void initState() {
    super.initState();
    // Initialiser le décompte
    _startTimer();
  }

  void _startTimer() {
    _updateTimeRemaining(); // Mettre à jour immédiatement
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTimeRemaining(); // Mettre à jour chaque seconde
    });
  }

  void _updateTimeRemaining() {
    if (widget.socialLinkModel.subscribeAt != null) {
      setState(() {
        _timeRemaining = _linkService.getTimeRemaining(widget.socialLinkModel);
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Annuler le timer pour éviter les fuites de mémoire
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = _timeRemaining['hours'] ?? 0;
    final minutes = _timeRemaining['minutes'] ?? 0;
    final seconds = _timeRemaining['seconds'] ?? 0;

    String displayTime = '';

    if (hours > 0) {
      displayTime = '$hours h';
    }

    if (minutes > 0 || (hours > 0 && minutes == 0)) {
      if (displayTime.isNotEmpty) displayTime += ':';
      displayTime += '$minutes m';
    }

    if (seconds > 0 || (hours == 0 && minutes == 0)) {
      if (displayTime.isNotEmpty) displayTime += ':';
      displayTime += '$seconds s';
    }
    return (!(widget.socialLinkModel.isClaimed ?? false) &&
            widget.socialLinkModel.isSubscribed)
        ? DefaultButton(
            backColor: widget.socialLinkModel.canClaimReward()
                ? Colors.purple.shade400
                : Colors.grey.shade300,
            text: displayTime.trim().isNotEmpty
                ? "Récompense [${displayTime.trim()}]"
                : "Récupérer",
            elevation: 1.0,
            textColor: widget.socialLinkModel.canClaimReward()
                ? Colors.white
                : Colors.grey.shade600,
            fontSize: 14,
            height: 50,
            press: () {
              _linkService.setLinkIsClaimed(
                widget.socialLinkModel.id,
              );
              RewardAnimation.show(context);
              Future.delayed(const Duration(seconds: 3), () {
                RewardAnimation.hide(context);
              });

              Navigator.of(context).pop(true);
            },
          )
        : const SizedBox.shrink();
  }
}

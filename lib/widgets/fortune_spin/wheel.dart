import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/widgets/reward/reward_animation.dart';

import '../../themes/images/appImages.dart';
import '../customImageView.dart';
import 'roll_btn.dart';
import 'small_spin_widget/small_spin_widget.dart';
import 'wheel_data/wheel_constant.dart';

class FortuneWheelWidget extends StatefulWidget {
  const FortuneWheelWidget({super.key});

  @override
  State<FortuneWheelWidget> createState() => _FortuneWheelWidgetState();
}

class _FortuneWheelWidgetState extends State<FortuneWheelWidget> {
  // final selected = StreamController<int>();
  // // final selectedIndex = useStream(selected.stream, initialData: 0).data ?? 0;
  // bool isAnimating = false;
  // int selectedIndex = 0;

  // void handleRoll() {
  //   selected.add(
  //     roll(Constants.fortuneValues.length),
  //   );
  // }

  StreamController<int> _selected = StreamController<int>();
  int _selectedIndex = 0;
  bool _isAnimating = false;
  bool isClaimed = false;

  @override
  void initState() {
    super.initState();
    // _selected = StreamController<int>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selected.stream.listen((index) {
        setState(() {
          _selectedIndex = index;
        });
      });
    });
  }

  @override
  void dispose() {
    _selected.close();
    super.dispose();
  }

  void _handleRoll() {
    _selected.add(
      roll(Constants.fortuneValues.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          SizedBox.square(
            dimension: MediaQuery.of(context).size.width * 0.9,
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(-1, -1), color: Colors.grey.shade200)
                  ],
                  image: DecorationImage(
                      image: AssetImage(Images.circleBorder),
                      fit: BoxFit.contain)),
              child: Container(
                // constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Themecolors.Color3.withOpacity(0.95),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.deepPurple.shade200,
                      Colors.deepPurple.shade300,
                      Colors.deepPurple.shade400,
                      Colors.deepPurple.shade400,
                      Colors.deepPurple.shade500,
                      Colors.deepPurple.shade600,
                      const Color(0xFF512DA8),
                    ],
                  ),
                  border: Border.all(color: Colors.deepPurple, width: 1.0),
                ),
                padding: const EdgeInsets.all(2),
                child: FortuneWheel(
                  alignment: Alignment.topCenter,
                  selected: _selected.stream,
                  onAnimationStart: () {
                    setState(() {
                      _isAnimating = true;
                    });
                  },
                  onAnimationEnd: () {
                    setState(() {
                      _isAnimating = false;
                      isClaimed = true;
                      RewardAnimation.show(context);
                      Future.delayed(const Duration(seconds: 3), () {
                        RewardAnimation.hide(context);
                      });
                    });
                  },
                  onFling: !isClaimed ? _handleRoll : null,
                  hapticImpact: HapticImpact.heavy,
                  curve: FortuneCurve.spin,
                  animateFirst: false,
                  indicators: [
                    FortuneIndicator(
                      alignment: Alignment.topCenter,
                      child: TriangleIndicator(
                        color: Colors.white,
                        elevation: 5.0,
                      ), /*CustomImageView(
                          imagePath: Images.down_arrow,
                          height: 35,
                          width: 35,
                          fit: BoxFit.contain,
                          color: Colors.white,
                        )*/
                    ),
                  ],
                  items: [
                    for (Map<String, dynamic> it in Constants.fortuneValues)
                      FortuneItem(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  it['coins'],
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CustomImageView(
                                  imagePath: it['coins'] == 'bonus'
                                      ? Images.game_gift
                                      : Images.coin_dollar,
                                  fit: BoxFit.contain,
                                  height: it['coins'] == 'bonus' ? 30 : 20,
                                  width: it['coins'] == 'bonus' ? 30 : 20,
                                ),
                              ]),
                          onTap: () => print(it['coins'])),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          SmallSpinWidget(
            boutonStyle: true,
            rollWheel: _isAnimating
                ? null
                : !isClaimed
                    ? _handleRoll
                    : null,
          )
        ],
      ),
    );
  }
}

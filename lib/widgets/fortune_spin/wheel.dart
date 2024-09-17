import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; 

import 'roll_btn.dart';
import 'wheel_data/wheel_constant.dart';

class FortuneWheelPage extends HookWidget {
  // static const kRouteName = 'FortuneWheelPage';

  // static void go(BuildContext context) {
  //   context.goNamed(kRouteName);
  // }

  @override
  Widget build(BuildContext context) {
    final alignment = useState(Alignment.topCenter);
    final selected = useStreamController<int>();
    final selectedIndex = useStream(selected.stream, initialData: 0).data ?? 0;
    final isAnimating = useState(false);

   
    void handleRoll() {
      selected.add(
        roll(Constants.fortuneValues.length),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [ 
          SizedBox(height: 8),
          RollButtonWithPreview(
            selected: selectedIndex,
            items: Constants.fortuneValues,
            onPressed: isAnimating.value ? null : handleRoll,
          ),
          SizedBox(height: 8),
          Expanded(
            child: FortuneWheel(
              alignment: alignment.value,
              selected: selected.stream,
              onAnimationStart: () => isAnimating.value = true,
              onAnimationEnd: () => isAnimating.value = false,
              onFling: handleRoll,
              hapticImpact: HapticImpact.heavy,
              indicators: [
                FortuneIndicator(
                  alignment: alignment.value,
                  child: TriangleIndicator(),
                ),
              ],
              items: [
                for (var it in Constants.fortuneValues)
                  FortuneItem(child: Text(it), onTap: () => print(it))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

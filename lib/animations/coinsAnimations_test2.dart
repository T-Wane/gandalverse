import 'package:flutter/material.dart';

class CoinAnimation extends StatefulWidget {
  const CoinAnimation({super.key});

  @override
  _CoinAnimationState createState() => _CoinAnimationState();
}

class _CoinAnimationState extends State<CoinAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )
      ..forward()
      ..addListener(() {
        if (_controller.isCompleted) {
          _controller.repeat();
        }
      });

    _opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Coins icon
                const Icon(
                  Icons.attach_money,
                  size: 100,
                ),
                // Flashing light effect
                Opacity(
                  opacity: _opacityAnimation.value,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.yellow.withOpacity(0.7),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
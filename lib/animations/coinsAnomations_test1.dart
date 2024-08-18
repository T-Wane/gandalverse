// Votre classe FlyCoinAnimation
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gandalverse/core/providers/charge_provider.dart';
import 'package:gandalverse/core/repositories/tabAndEarnRepository.dart';
import 'package:gandalverse/core/services/click_manager.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/painter/liquid_painter.dart';
import 'package:gandalverse/widgets/painter/radial_painter.dart';

import '../widgets/painter/constants/colors.dart';

class FlyCoinAnimation extends StatefulWidget {
  const FlyCoinAnimation({super.key});

  @override
  State<FlyCoinAnimation> createState() => FlyCoinAnimationState();
}

class FlyCoinAnimationState extends State<FlyCoinAnimation>
    with TickerProviderStateMixin {
  TapAndEarnRepository _earnRepository = getIt<TapAndEarnRepository>();
  ChargeManager _chargeManager = getIt<ChargeManager>();
  final ClickManager clickManager = ClickManager(getIt<ChargeManager>());
  final List<AnimationItem> _animationItems = [];

  late AnimationController _controller;
  bool isPlaying = false;
  int maxDuration = 10;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: maxDuration))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isPlaying = false;
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    // Dispose all animation controllers when the widget is disposed
    for (var item in _animationItems) {
      item.controller.dispose();
    }
    super.dispose();
  }

  void _startAnimation() {
    if (_chargeManager.points > 0) {
      final controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      )..forward();

      final newAnimationItem = AnimationItem(controller: controller);

      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.dispose();
          setState(() {
            _animationItems.remove(newAnimationItem);
            clickManager.onClick(_earnRepository.incrementCoins);
          });
        }
      });

      setState(() {
        _animationItems.add(newAnimationItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: Stack(
        children: [
          Center(
            child: SizedBox.square(
              dimension: 250,
              child: PlayButton(
                onPressed: _startAnimation,
                initialIsPlaying: false,
                playIcon: const Icon(Icons.play_arrow),
                pauseIcon: const Icon(Icons.pause),
              ),
            ),
          ),
          ..._animationItems.map((animationItem) {
            final opacityAnimation =
                Tween<double>(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(
                parent: animationItem.controller,
                curve: Curves.easeOut,
              ),
            );

            final radiusAnimation =
                Tween<double>(begin: 0.0, end: 100.0).animate(
              CurvedAnimation(
                parent: animationItem.controller,
                curve: Curves.easeOut,
              ),
            );

            return AnimatedBuilder(
              animation: animationItem.controller,
              builder: (context, child) {
                final angle =
                    (animationItem.controller.value * 2 * pi) % (2 * pi);
                final radius = radiusAnimation.value;
                final x = radius * cos(angle);
                final y = radius * sin(angle);

                return FadeTransition(
                  opacity: opacityAnimation,
                  child: Transform.translate(
                    offset: Offset(x, y),
                    child: Center(
                      child: Text(
                        '+1',
                        style: TextStyle(
                            fontSize: 45,
                            color: Colors.yellow,
                            fontFamily: "Aller",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}

// Classe PlayButton
class PlayButton extends StatefulWidget {
  final bool initialIsPlaying;
  final Icon playIcon;
  final Icon pauseIcon;
  final VoidCallback onPressed;

  PlayButton({
    required this.onPressed,
    this.initialIsPlaying = false,
    this.playIcon = const Icon(Icons.play_arrow),
    this.pauseIcon = const Icon(Icons.pause),
  }) : assert(onPressed != null);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(seconds: 5);
  static const _kRotationDuration = Duration(seconds: 6);

  late bool isPlaying;

  // rotation and scale animations
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  double _rotation = 0;
  double _scale = 0.85;

  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  bool get _showWaves => !_scaleController.isDismissed;

  void _updateRotation() => _rotation = _rotationController.value * 2 * pi;
  void _updateScale() => _scale = (_scaleController.value * 0.2) + 0.85;

  @override
  void initState() {
    isPlaying = widget.initialIsPlaying;
    _rotationController =
        AnimationController(vsync: this, duration: _kRotationDuration)
          ..addListener(() => setState(_updateRotation))
          ..repeat();

    _scaleController =
        AnimationController(vsync: this, duration: _kToggleDuration)
          ..addListener(() => setState(_updateScale));
    _scaleController.forward();
    super.initState();
  }

  Widget _buildIcon(bool isPlaying) {
    return SizedBox.expand(
      key: ValueKey<bool>(isPlaying),
      child: IconButton(
        icon: CustomImageView(
          imagePath: Images.aatarYaraOil, // Remplacez par le chemin correct
          fit: BoxFit.contain,
          width: 200,
        ),
        onPressed: widget.onPressed, // Appel de la fonction de rappel
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_showWaves) ...[
            Blob(
                color: Colors.deepPurple.shade400.withOpacity(0.5),
                scale: _scale * 0.91,
                rotation: _rotation),
            Blob(
                color: Colors.purple.shade400.withOpacity(0.5),
                scale: _scale * 0.92,
                rotation: _rotation * 2),
          ],
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color3.withOpacity(0.9),
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
                    Color(0xFF512DA8),
                  ]),
              border: Border.all(color: Colors.deepPurple, width: 1.0),
            ),
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color3.withOpacity(0.9),
                  image: DecorationImage(
                      image: AssetImage(Images.circleBtn), fit: BoxFit.fill)
                  /*gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.deepPurple.shade200, Color3]),*/
                  ),
              child: AnimatedSwitcher(
                duration: _kToggleDuration,
                child: _buildIcon(isPlaying),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}

class Blob extends StatelessWidget {
  final double rotation;
  final double scale;
  final Color color;

  const Blob({required this.color, this.rotation = 0, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(150),
              topRight: Radius.circular(240),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimationItem {
  AnimationItem({required this.controller});
  final AnimationController controller;
}

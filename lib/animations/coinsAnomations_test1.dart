import 'dart:math';

import 'package:flutter/material.dart';

class FlyCoinAnimation extends StatefulWidget {
  const FlyCoinAnimation({super.key});

  @override
  State<FlyCoinAnimation> createState() => FlyCoinAnimationState();
}

class FlyCoinAnimationState extends State<FlyCoinAnimation> {
  var _animationSwich = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Stack(
          children: [
            // Left
            Positioned(
              right: 16,
              bottom: 16,
              child: BaseAnimationWidget(
                type: AnimationType.OFFSET,
                duration: const Duration(seconds: 1),
                body: const Icon(Icons.attach_money),
                offset: Offset(-width, 0),
                offsetType: OffsetType.Left,
                animationSwich: () => _animationSwich,
              ),
            ),
            // Up
            Positioned(
              right: 16,
              bottom: 16,
              child: BaseAnimationWidget(
                type: AnimationType.OFFSET,
                duration: const Duration(seconds: 1),
                body: const Icon(Icons.attach_money),
                offset: Offset(0, -height),
                offsetType: OffsetType.UP,
                animationSwich: () => _animationSwich,
              ),
            ),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        child: _animationSwich
            ? BaseAnimationWidget(
                type: AnimationType.ROTATION,
                duration: const Duration(seconds: 1),
                body: const Icon(Icons.attach_money),
                offset: Offset(-width, 0),
                offsetType: OffsetType.Left,
                rotationValue: pi,
                animationSwich: () => _animationSwich,
              )
            : BaseAnimationWidget(
                type: AnimationType.ROTATION,
                duration: const Duration(seconds: 1),
                body: const Icon(Icons.attach_money),
                offset: Offset(-width, 0),
                offsetType: OffsetType.Left,
                rotationValue: pi,
                animationSwich: () => _animationSwich,
              ),
        onPressed: () {
          _animationSwich = !_animationSwich;
          setState(() {});
        },
      ),
    );
  }
}

enum AnimationType {
  ROTATION,
  OFFSET,
}

enum OffsetType {
  UP,
  Left,
}

typedef AnimationSwich = bool Function();

class BaseAnimationWidget extends StatefulWidget {
  const BaseAnimationWidget(
      {Key? key,
      required this.type,
      required this.body,
      this.animationSwich,
      this.rotationValue,
      this.offset,
      this.duration,
      this.offsetType})
      : assert(type == AnimationType.ROTATION
            ? rotationValue != null
            : type == AnimationType.OFFSET
                ? offset != null && offsetType != null
                : true),
        super(key: key);
  final AnimationSwich? animationSwich;
  final Widget body;
  final Offset? offset;
  final double? rotationValue;
  final AnimationType type;
  final Duration? duration;
  final OffsetType? offsetType;
  @override
  State<BaseAnimationWidget> createState() => _BaseAnimationWidgetState();
}

class _BaseAnimationWidgetState extends State<BaseAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: widget.duration ?? const Duration(milliseconds: 300),
        vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Offset get _offset => widget.offsetType == OffsetType.UP
      ? Offset(
          widget.offset!.dx, widget.offset!.dy * _animationController.value)
      : Offset(
          widget.offset!.dx * _animationController.value, widget.offset!.dy);
  @override
  Widget build(BuildContext context) {
    if (widget.animationSwich == null) {
      DoNothingAction();
    } else if (mounted && widget.animationSwich!()) {
      _animationController.forward();
    } else if (mounted && !widget.animationSwich!()) {
      _animationController.reverse();
    }
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return widget.type == AnimationType.ROTATION
              ? Transform.rotate(
                  angle: widget.rotationValue! * _animationController.value,
                  child: widget.body)
              : Transform.translate(
                  offset: _offset,
                  child: widget.body,
                );
        });
  }
}
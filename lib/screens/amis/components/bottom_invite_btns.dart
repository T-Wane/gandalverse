import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/screens/amis/amis_page.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class bottomInviteBtns extends StatefulWidget {
  const bottomInviteBtns({
    super.key,
  });

  @override
  State<bottomInviteBtns> createState() => _bottomInviteBtnsState();
}

class _bottomInviteBtnsState extends State<bottomInviteBtns>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  Color Color3 = const Color.fromARGB(255, 18, 40, 70);

  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(min: 0.6, reverse: true);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    _controller.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void shareViaTelegram(String url, String text) async {
    final encodedUrl = Uri.encodeComponent(url);
    final encodedText = Uri.encodeComponent(text);
    final telegramUrl =
        'https://t.me/share/url?url=$encodedUrl&text=$encodedText';

    if (await canLaunch(telegramUrl)) {
      await launch(telegramUrl);
    } else {
      throw 'Could not launch $telegramUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Transform.scale(
                scale: 1 - _controller.value,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.deepPurple.shade300,
                          Colors.deepPurple.shade400,
                          Colors.deepPurple.shade500,
                          Colors.deepPurple.shade600,
                        ]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultTextStyle(
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.white, fontFamily: "Aller"),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              RotateAnimatedText('Inviter un ami'),
                              RotateAnimatedText('Gagner plus de coins'),
                              RotateAnimatedText('Offrer à un ami du capital'),
                            ],
                            onTap: () {
                              shareViaTelegram(
                                  "https://t.me/starbrig_bot/GoGv/telegram",
                                  "Plongez dans Gandalverse 🌍\nConstruisez votre monde dans le premier métavers pour le prochain milliard d'Africains. Gagnez des jetons, montez en grade, et signez des partenariats pour des commissions. Invitez des amis, augmentez votre influence et remportez des panneaux publicitaires ou des immeubles. Rejoignez-nous et façonnez l'avenir dès aujourd'hui !");
                            },
                            isRepeatingAnimation: true,
                            repeatForever: true,
                          ),
                        ),
                        // const Icon(
                        //   CupertinoIcons.person_crop_circle_badge_plus,
                        //   color: Colors.white70,
                        //   size: 20,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            child: Container(
              height: 50,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.deepPurple.shade300,
                      Colors.deepPurple.shade400,
                      Colors.deepPurple.shade500,
                      Colors.deepPurple.shade600,
                    ]),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  CupertinoIcons.link,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedTextExample {
  final String label;
  final Color? color;
  final Widget child;

  const AnimatedTextExample({
    required this.label,
    required this.color,
    required this.child,
  });
}

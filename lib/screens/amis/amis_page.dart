import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/screens/amis/elementCard.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AmisPage extends StatefulWidget {
  const AmisPage({super.key});

  @override
  State<AmisPage> createState() => _AmisPageState();
}

class _AmisPageState extends State<AmisPage> {
  Color Color3 = const Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: bottomInviteBtns(),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                'Invitez des amis!',
                maxLines: 1,
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Color3, fontFamily: "Aller"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                'Recevez des bonus exceptionnelles',
                maxLines: 1,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Color3.withOpacity(0.7), fontFamily: "Aller"),
              ),
            ),
            inviterAmiCard(Color3: Color3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      'Liste de vos amis (2)',
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Color3.withOpacity(0.7), fontFamily: "Aller"),
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.refresh_thick,
                    color: Colors.white70,
                    size: 15,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class bottomInviteBtns extends StatefulWidget {
  const bottomInviteBtns({
    super.key,
  });

  @override
  State<bottomInviteBtns> createState() => _bottomInviteBtnsState();
}

class _bottomInviteBtnsState extends State<bottomInviteBtns>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Color Color3 = const Color.fromARGB(255, 18, 40, 70);

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(min: 0.6, reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              child: FadeTransition(
                opacity: _animationController,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.deepPurple.shade400,
                          Colors.deepPurple.shade500,
                          Colors.deepPurple.shade500,
                          Colors.deepPurple.shade600,
                          Colors.deepPurple.shade700,
                          Colors.deepPurple.shade700,
                        ]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          'Inviter un ami ',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.white, fontFamily: "Aller"),
                        ),
                        Icon(
                          CupertinoIcons.person_crop_circle_badge_plus,
                          color: Color3,
                          size: 15,
                        ),
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
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.deepPurple.shade400,
                      Colors.deepPurple.shade500,
                      Colors.deepPurple.shade500,
                      Colors.deepPurple.shade600,
                      Colors.deepPurple.shade700,
                      Colors.deepPurple.shade700,
                    ]),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  LineAwesomeIcons.copy,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class inviterAmiCard extends StatelessWidget {
  const inviterAmiCard({
    super.key,
    required this.Color3,
  });

  final Color Color3;

  @override
  Widget build(BuildContext context) {
    return ElementCard(
        title: 'Inviter un ami',
        leadingWidget: CustomImageView(
          imagePath: "assets/images/gift.png",
          height: 60,
          width: 60,
          fit: BoxFit.contain,
        ),
        SubWidget: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: "assets/images/coin.png",
                      fit: BoxFit.contain,
                      height: 20,
                      width: 20,
                    ),
                    AutoSizeText(
                      '+7500',
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.yellow.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    Text(' pour vous et votre ami')
                  ],
                ),
              )
            ],
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Color3, fontFamily: "Aller"),
          ),
        ),
        backColors: const [
          Colors.white,
          Colors.white,
        ],
        press: () {},
        titleColor: Color3);
  }
}

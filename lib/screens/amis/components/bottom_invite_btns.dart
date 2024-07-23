import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/screens/amis/amis_page.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        const Icon(
                          CupertinoIcons.person_crop_circle_badge_plus,
                          color: Colors.white70,
                          size: 20,
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

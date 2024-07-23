import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/screens/amis/components/elementCard.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'components/bottom_invite_btns.dart';
import 'components/inviter_ami_card.dart';

class AmisPage extends StatefulWidget {
  const AmisPage({super.key});

  @override
  State<AmisPage> createState() => _AmisPageState();
}

class _AmisPageState extends State<AmisPage> {
  Color Color3 = const Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Column(children: [
          Flexible(
              child: Column(
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
              inviterAmiWithPremiumCard(
                Color3: Color3,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(children: [
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
                  Icon(
                    CupertinoIcons.refresh_thick,
                    color: Color3,
                    size: 20,
                  ),
                ]),
              )
            ],
          )),
          const bottomInviteBtns(),
        ]),
      ),
    );
  }
}

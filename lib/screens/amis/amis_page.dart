import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/components/rounded_btn_back.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/screens/amis/components/elementCard.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'components/ami_item_card.dart';
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
      backgroundColor: Colors.white,
      body: Consumer<UserProvider>(builder: (context, _userProvider, child) {
        return SafeArea(
          child: Column(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: BtnRoundedIconBack(
                  couleur: Themecolors.Color3,
                  onpress: () {
                    //Navigator.of(context).pop();
                    context.pop();
                  },
                ),
              ),
            ),
            Flexible(
              child: Column(children: [
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            'Liste de vos amis (${_userProvider.friends.length})',
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Color3.withOpacity(0.7),
                                    fontFamily: "Aller"),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: Icon(
                            CupertinoIcons.refresh_thick,
                            color: Color3,
                            size: 20,
                          ),
                        ),
                      ]),
                ),
                Flexible(child: _buildFirendsList(_userProvider))
              ]),
            ),
            const bottomInviteBtns(),
          ]),
        );
      }),
    );
  }

  Widget _buildFirendsList(UserProvider _userProvider) {
    return FutureBuilder<List<UserModel>>(
      future: _userProvider.getMyFirends(refresh: true),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        // Afficher le loader pendant que les données se chargent
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Afficher un message d'erreur s'il y a une erreur
        if (snapshot.hasError) {
          print('Snapshot error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Afficher un message si aucune donnée n'est disponible
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(5),
            child: Center(
              child: Text(
                'No friends found',
                textAlign: TextAlign.center,
                style: TextStyle(color: Themecolors.Color3),
              ),
            ),
          );
        }

        // Afficher la liste des amis si les données sont disponibles
        List<UserModel> dataList = snapshot.data!;
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(5),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              UserModel friend = dataList[index];
              return AmiItemCard(friend: friend);
            },
          ),
        );
      },
    );
  }
}

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/components/profil_details.dart';
import 'package:gandalverse/core/data/levels.dart';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:gandalverse/core/modeles/player/player_model.dart';
import 'package:gandalverse/core/providers/player_provider.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/percent_indicator/linear_percent_indicator.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

import 'package:telegram_web_app/telegram_web_app.dart';

import '../core/functions/coins_value_formateur.dart';
import 'bottomSheet_modal.dart';

class ProfilDetailsContentBottomSheet extends StatefulWidget {
  static void show(BuildContext context,
          {Key? key,
          Color backColor = Colors.white,
          required TelegramWebApp telegram,
          bool isDismissible = true}) =>
      showModalBottomSheet(
              enableDrag: true,
              isScrollControlled: true,
              isDismissible: isDismissible,
              context: context,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(15),
                  topStart: Radius.circular(15),
                ),
              ),
              builder: (context) => PointerInterceptor(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: ProfilDetailsContentBottomSheet(
                        telegram: telegram,
                      ))))
          .then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  ProfilDetailsContentBottomSheet({Key? key, required this.telegram})
      : super(key: key);

  TelegramWebApp telegram;

  @override
  State<ProfilDetailsContentBottomSheet> createState() =>
      _ProfilDetailsContentBottomSheetState();
}

class _ProfilDetailsContentBottomSheetState
    extends State<ProfilDetailsContentBottomSheet> {
  late PageController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = PageController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Fonction pour faire défiler vers la gauche
  void _scrollLeft() {
    final page = _scrollController.page ?? 0;
    if (page > 0) {
      _scrollController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Fonction pour faire défiler vers la droite
  void _scrollRight() {
    final page = _scrollController.page ?? 0;
    if (page < (levels.length - 1)) {
      _scrollController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  //  entry.value['image']
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, _userProvider, child) {
      return PointerInterceptor(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          child: PointerInterceptor(
              debug: false,
              child: PageView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                children: levels.entries
                    .map((entry) => Stack(children: [
                          PointerInterceptor(
                            debug: false,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(top: 100),
                              decoration: BoxDecoration(
                                  color: Colors.purpleAccent.withOpacity(0.6),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.purpleAccent.withOpacity(0.5),
                                      offset: const Offset(1, 1),
                                      blurRadius: 10,
                                      spreadRadius: 4,
                                    )
                                  ]),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.only(top: 2),
                                padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Column(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 5),
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: closeIcon(context))),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 2),
                                          child: Divider(
                                            color: Colors.grey.shade200,
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                                //  mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            _scrollLeft();
                                                          },
                                                          icon: Icon(
                                                            CupertinoIcons
                                                                .chevron_left,
                                                            color: Themecolors
                                                                .Color3,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 2),
                                                          child: Text(
                                                            "${entry.value['title']}",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Themecolors
                                                                        .Color3
                                                                    .withOpacity(
                                                                        0.9),
                                                                fontFamily:
                                                                    "Aller",
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            _scrollRight();
                                                          },
                                                          icon: Icon(
                                                            CupertinoIcons
                                                                .chevron_right,
                                                            color: Themecolors
                                                                .Color3,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  if (entry.value['index'] ==
                                                      (_userProvider
                                                              .user?.level ??
                                                          1)) ...[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 2,
                                                          horizontal: 10),
                                                      child: coinsProgress(
                                                          userCoins:
                                                              _userProvider.user
                                                                      ?.coins ??
                                                                  0,
                                                          userLevelCoins: entry
                                                                  .value[
                                                              'coins_required'],
                                                          leading: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 5,
                                                                    right: 2),
                                                            child: Text(
                                                              formatValue(
                                                                  double.parse(
                                                                      "${_userProvider.user?.coins ?? 0}")),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    Themecolors
                                                                        .Color3,
                                                                fontFamily:
                                                                    "Aller",
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ),
                                                          trailling: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 5,
                                                                    right: 2),
                                                            child: Text(
                                                              formatValue(entry
                                                                      .value[
                                                                  'coins_required']),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .purple
                                                                      .shade400,
                                                                  fontFamily:
                                                                      "Aller",
                                                                  fontSize: 14),
                                                            ),
                                                          )),
                                                    )
                                                  ] else ...[
                                                    Text(
                                                      "${entry.value['coins_required']}",
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Themecolors
                                                              .Color3,
                                                          fontFamily: "Aller",
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ],
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  AutoSizeText(
                                                    'le classement des joueurs',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                          color:
                                                              Themecolors.Color3
                                                                  .withOpacity(
                                                                      0.95),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),

                                                  Flexible(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CustomImageView(
                                                        imagePath: Images.soon,
                                                        height: 200,
                                                        width: 200,
                                                        fit: BoxFit.contain,
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: AutoSizeText(
                                                          'Bientôt...',
                                                          maxLines: 1,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineSmall!
                                                              .copyWith(
                                                                  color:
                                                                      Themecolors
                                                                          .Color3,
                                                                  fontFamily:
                                                                      "Aller",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                  // Expanded(
                                                  //     child: _buildPlayersList(
                                                  //         levelIndex: entry
                                                  //             .value['index']))
                                                ]),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                          //---------------//
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color3.withOpacity(0.1),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.purpleAccent.withOpacity(0.1),
                                  ),
                                  child: CustomImageView(
                                    height: 150,
                                    width: 150,
                                    imagePath:
                                        entry.value['image'], //image du niveau
                                    radius: BorderRadius.circular(75),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: shareGvBtn(),
                          )
                        ]))
                    .toList(),
              )),
        ),
      );
    });
  }

  Widget _buildPlayersList({int levelIndex = 1}) {
    final futurePlayer = getIt<PlayerProvider>()
        .fetchAllPlayers(reload: false); // Utilisation d'un futur stable

    return FutureBuilder<List<PlayerModel>>(
      future: futurePlayer,
      builder:
          (BuildContext context, AsyncSnapshot<List<PlayerModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print('Snapshot error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        }

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
                'Pas d\'amis pour le moment. Invitez des amis et ensemble profiter de bonus exclusifs !',
                textAlign: TextAlign.center,
                style: TextStyle(color: Themecolors.Color3),
              ),
            ),
          );
        }

        List<PlayerModel> dataList = snapshot.data!;

        List<PlayerModel> levelPlayers =
            dataList.where((plr) => plr.level == levelIndex).toList();
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(5),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: levelPlayers.length,
            itemBuilder: (context, index) {
              PlayerModel player = levelPlayers[index];
              return playerItem(player: player, index: index);
            },
          ),
        );
      },
    );
  }
}

class shareGvBtn extends StatefulWidget {
  const shareGvBtn({
    super.key,
  });

  @override
  State<shareGvBtn> createState() => _shareGvBtnState();
}

class _shareGvBtnState extends State<shareGvBtn> with TickerProviderStateMixin {
  late AnimationController _animationController;
  Color Color3 = const Color.fromARGB(255, 18, 40, 70);

  late double _scale;
  late AnimationController _controller;

  UserProvider _userProvider = getIt<UserProvider>();

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

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1 - _controller.value,
      child: PointerInterceptor(
        debug: false,
        child: GestureDetector(
          onTap: () {
            _userProvider.inviterAmi();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            width: double.infinity,
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
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: AutoSizeText(
                      "Partager GandalVerse",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        fontFamily: 'Aller',
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: Icon(
                      Icons.share,
                      color: Themecolors.Color3,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class playerItem extends StatelessWidget {
  playerItem({super.key, required this.player, required this.index});

  final PlayerModel player;
  int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey.shade100,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.all(2),
          child: CustomImageView(
            imagePath: player.profileImage ?? "assets/images/new/avatar.png",
            height: 40,
            width: 40,
            radius: BorderRadius.circular(20),
            fit: BoxFit.cover,
          ),
        ),
        title: AutoSizeText(
          "${player.firstName ?? ''} ${player.lastName ?? ''} ",
          minFontSize: 12,
          maxLines: 2,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13,
            color: Themecolors.Color3.withOpacity(0.8),
            fontWeight: FontWeight.w600,
            fontFamily: 'Aller',
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: Images.coin_dollar,
                fit: BoxFit.contain,
                height: 15,
                width: 15,
              ),
              const SizedBox(width: 5),
              AutoSizeText(
                player.gradleFormate,
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  color: Themecolors.Color3,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ), // Affichage du rang
        trailing: Text(
          "$index",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 15,
            color: Themecolors.Color3,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class coinsProgress extends StatefulWidget {
  final int userLevelCoins; // Niveau actuel de l'utilisateur
  final int userCoins; // Coins de l'utilisateur
  Widget? leading;
  Widget? trailling;

  coinsProgress(
      {required this.userLevelCoins,
      required this.userCoins,
      this.leading,
      this.trailling});

  @override
  State<coinsProgress> createState() => _coinsProgressState();
}

class _coinsProgressState extends State<coinsProgress> {
  @override
  Widget build(BuildContext context) {
    final progress = widget.userCoins / widget.userLevelCoins;

    return LinearPercentIndicator(
      percent: progress.clamp(0.0, 1.0),
      isRTL: false,
      backgroundColor: Themecolors.Color3.withOpacity(0.2),
      animateFromLastPercent: true,
      restartAnimation: true,
      linearGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade200,
            Colors.deepPurple.shade300,
            Colors.deepPurple.shade400,
            Colors.deepPurple.shade400,
            Colors.deepPurple.shade500,
            Colors.deepPurple.shade600,
            Colors.deepPurple.shade700,
          ]),
      lineHeight: 20.0,
      leading: widget.leading,
      trailing: widget.trailling,
      barRadius: const Radius.circular(8),
    );
  }
}

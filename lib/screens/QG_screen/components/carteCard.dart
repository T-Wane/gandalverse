import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/core/repositories/user_repository.dart';
import 'package:gandalverse/core/services/QG_services/QGService.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:provider/provider.dart';

class CarteCard extends StatelessWidget {
  CarteCard(
      {super.key,
      required this.carte,
      required this.qgService,
      required this.isUnlocked,
      this.contrainteMessage});

  QGService qgService;
  CarteModel carte;
  bool isUnlocked;
  String? contrainteMessage;

  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CardContentBottomSheet.show(context,
            child: bureauCarteDetails(
                Color3: Color3,
                carte: carte,
                qgService: qgService,
                isUnlocked: isUnlocked,
                contrainteMessage: contrainteMessage),
            image: carte.image);
      },
      child: Consumer<UserProvider>(builder: (context, _userProvider, child) {
        return Container(
          margin: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(207, 18, 40, 70),
                Color.fromARGB(219, 18, 40, 70),
                Color.fromARGB(234, 18, 40, 70),
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black87,
                      image: DecorationImage(
                        image: AssetImage(carte.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.deepPurple.shade400,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomImageView(
                                imagePath: Images.coin_dollar,
                                fit: BoxFit.contain,
                                height: 15,
                                width: 15,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              AutoSizeText(
                                carte.forceFormate,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Grade apporté",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.white70,
                                fontFamily: "Aller",
                                fontSize: 7),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0),
              width: double.infinity,
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 2,
                vertical: 2,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        carte.nom,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          color: Colors.white30,
                          thickness: 0.1,
                        ),
                      ),
                      if (!isUnlocked) ...[
                        Text(
                          contrainteMessage ?? 'Verrouillé',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                        Icon(
                          Icons.lock,
                          color: Themecolors.ColorWhite,
                        ),
                      ] else ...[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AutoSizeText(
                                'Niv ${carte.niveau}',
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w200,
                                    ),
                              ),
                              const VerticalDivider(
                                color: Colors.white54,
                                width: 0.4,
                                thickness: 0.1,
                              ),
                              Row(children: [
                                Opacity(
                                  opacity: (_userProvider.user?.coins ?? 0) >
                                          carte.prixReel
                                      ? 1
                                      : 0.7,
                                  child: CustomImageView(
                                    imagePath: Images.coin_dollar,
                                    fit: BoxFit.contain,
                                    height: 15,
                                    width: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                AutoSizeText(
                                  carte.prixFormate,
                                  maxLines: 1,
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        color: carte.estAchete
                                            ? Colors.white
                                            : Colors.white70,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ]),
                            ]),
                      ]
                    ]),
              ),
            ),
          ]),
        );
      }),
    );
  }
}

void showCustomSnackBar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => CustomSnackBar(
      message: message,
    ),
  );

  // Ajouter l'overlay entry
  overlay.insert(overlayEntry);

  // Supprimer l'overlay entry après la durée du snackBar
  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}

class bureauCarteDetails extends StatefulWidget {
  bureauCarteDetails({
    super.key,
    required this.Color3,
    required this.carte,
    required this.qgService,
    required this.isUnlocked,
    this.contrainteMessage,
  });

  final Color Color3;
  final CarteModel carte;

  QGService qgService;

  bool isUnlocked;
  String? contrainteMessage;

  @override
  State<bureauCarteDetails> createState() => _bureauCarteDetailsState();
}

class _bureauCarteDetailsState extends State<bureauCarteDetails> {
  //UserProvider _userProvider = getIt<UserProvider>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, _userProvider, child) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            widget.carte.nom,
            maxLines: 1,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 15,
                color: widget.Color3,
                fontFamily: "Aller",
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
          // AutoSizeText(
          //   widget.carte.carteId ?? '--',
          //   maxLines: 1,
          //   textAlign: TextAlign.right,
          //   style: Theme.of(context).textTheme.labelSmall!.copyWith(
          //         color: Colors.red,
          //         fontWeight: FontWeight.w400,
          //       ),
          // ),
          AutoSizeText(
            widget.carte.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: widget.Color3.withOpacity(0.95),
                  fontWeight: FontWeight.normal,
                ),
          ),
          if ((widget.carte.competences?.toList() ?? []).isNotEmpty) ...[
            AutoSizeText(
              "Compétences: ${widget.carte.competences?.join(" - ")}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: widget.Color3.withOpacity(0.95),
                    fontWeight: FontWeight.normal,
                  ),
            )
          ],
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Grade Apporté : ",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: widget.Color3,
                      fontFamily: "Aller",
                      fontSize: 12),
                ),
                const SizedBox(
                  width: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      widget.carte.forceFormate,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 15,
                          color: widget.Color3,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.lineThrough),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      width: 50,
                      height: 20,
                      child: CustomImageView(
                        imagePath: Images.right_arrow,
                        fit: BoxFit.contain,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.square(
                          dimension: 25,
                          child: Stack(
                            children: [
                              CustomImageView(
                                imagePath: Images.coin_dollar,
                                fit: BoxFit.contain,
                                height: 25,
                                width: 25,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: CustomImageView(
                                  imagePath: Images.up_arrow,
                                  fit: BoxFit.contain,
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        AutoSizeText(
                          widget.carte
                              .formatValue(widget.carte.forceNextReelle),
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.Color3,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          //  AutoSizeText(
          //     "local coins ${widget.carte.getPrix}",
          //     maxLines: 1,
          //     presetFontSizes: const [22, 20, 18, 15, 14],
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       color: widget.Color3,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: Images.coin_dollar,
                fit: BoxFit.contain,
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 5),
              AutoSizeText(
                "${widget.carte.prixReel}",
                maxLines: 1,
                presetFontSizes: const [22, 20, 18, 15, 14],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.Color3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          if (widget.contrainteMessage != null) ...[
            Text(
              widget.contrainteMessage ?? 'Verrouillée',
              maxLines: 1,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: widget.Color3,
                fontFamily: "Aller",
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
          if (!widget.isUnlocked ||
              (_userProvider.user?.coins ?? 0) < widget.carte.prix) ...[
            DefaultButton(
                backColor: Colors.grey.shade200,
                text: 'Go',
                elevation: 1.0,
                textColor: Colors.grey.shade500,
                fontSize: 15,
                height: 50,
                press: () async {})
          ] else ...[
            StreamBuilder<bool>(
                stream: widget.qgService.loadingStream,
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return DefaultButtonWithchild(
                        backColor: Colors.purple.shade400,
                        elevation: 1.0,
                        height: 50,
                        press: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(2),
                          child: CircularProgressIndicator(
                            color: Colors.white70,
                            strokeWidth: 1.5,
                          ),
                        ));
                  } else {
                    return DefaultButton(
                        backColor: (_userProvider.user?.coins ?? 0) >=
                                widget.carte.prix
                            ? Colors.purple.shade400
                            : Colors.grey.shade200,
                        text: 'Go',
                        elevation: 1.0,
                        textColor: (_userProvider.user?.coins ?? 0) >=
                                widget.carte.prix
                            ? Colors.white
                            : Colors.grey.shade500,
                        fontSize: 15,
                        height: 50,
                        press: () async {
                          if ((_userProvider.user?.coins ?? 0) >=
                              widget.carte.prix) {
                            await _userProvider
                                .updateCardLevel(
                                    widget.qgService,
                                    CarteModel((b) => b
                                      ..carteId = widget.carte.carteId
                                      ..nom = widget.carte.nom
                                      ..description = widget.carte.description
                                      ..competences = BuiltList<String>.from(
                                              widget.carte.competences
                                                      ?.toList() ??
                                                  [])
                                          .toBuilder()
                                      ..image = widget.carte.image
                                      ..prix = widget.carte.prix
                                      ..tauxAugmentation =
                                          widget.carte.tauxAugmentation
                                      ..niveau = widget.carte.niveau
                                      ..estAchete = widget.carte.estAchete
                                      ..force = widget.carte.force
                                      ..tauxAugmentationForce =
                                          widget.carte.tauxAugmentationForce
                                      ..contrainteType =
                                          widget.carte.contrainteType
                                      ..valeurContrainte =
                                          widget.carte.valeurContrainte))
                                .whenComplete(() {
                              Navigator.of(context).pop();
                              setState(() {});
                            });
                          }
                        });
                  }
                }),
          ]
        ]),
      );
    });
  }
}

class CustomSnackBar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Duration duration;

  CustomSnackBar({
    required this.message,
    this.backgroundColor = Colors.black45,
    this.duration = const Duration(seconds: 2),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
          child: SnackBar(
            backgroundColor: backgroundColor,
            behavior: SnackBarBehavior.floating,
            content: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
            duration: duration,
          ),
        ),
      ),
    );
  }
}

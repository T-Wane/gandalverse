import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/core/modeles/carte.dart';
import 'package:gandalverse/core/services/service.dart';
import 'package:gandalverse/core/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class CarteCard extends StatelessWidget {
  CarteCard({super.key, required this.carte, required this.qgService});
  QGService qgService;
  Carte carte;
  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CardContentBottomSheet.show(context,
            child: bureauCarteDetails(
                Color3: Color3, carte: carte, qgService: qgService),
            image: carte.image);
      },
      child: Container(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.deepPurple.shade400,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomImageView(
                              imagePath: Images.gvt,
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
                              CustomImageView(
                                imagePath: Images.gvt,
                                fit: BoxFit.contain,
                                height: 15,
                                width: 15,
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ]),
                          ]),
                    ]),
              )),
        ]),
      ),
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
  });

  final Color Color3;
  final Carte carte;

  QGService qgService;

  @override
  State<bureauCarteDetails> createState() => _bureauCarteDetailsState();
}

class _bureauCarteDetailsState extends State<bureauCarteDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          AutoSizeText(
            widget.carte.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: widget.Color3.withOpacity(0.95),
                  fontWeight: FontWeight.normal,
                ),
          ),
          if ((widget.carte.competences ?? []).isNotEmpty) ...[
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
            child: Row(
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
                    CustomImageView(
                      imagePath: Images.gvt,
                      fit: BoxFit.contain,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 5),
                    AutoSizeText(
                      widget.carte.forceFormate,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        color: widget.Color3,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: Images.gvt,
                fit: BoxFit.contain,
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 5),
              AutoSizeText(
                "${widget.carte.getPrix}",
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
          StreamBuilder<bool>(
            stream: widget.qgService.loadingStream,
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.black45,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      content: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: CircularProgressIndicator(
                              color: Colors.white70,
                              strokeWidth: 1.5,
                            ),
                          ),
                          Expanded(
                            child: const Text(
                              "Mise à jour de la carte en cours...",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                });
                return SizedBox.shrink();
              } else {
                return SizedBox.shrink();
              }
            },
          ),
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
                  backColor: Colors.purple.shade400,
                  text: 'Go',
                  elevation: 1.0,
                  textColor: Colors.white,
                  fontSize: 15,
                  height: 50,
                  press: () async {
                    try {
                      await widget.qgService
                          .updateCarte(
                              widget.carte.nom,
                              Carte(
                                  nom: widget.carte.nom,
                                  description: widget.carte.description,
                                  competences: widget.carte.competences,
                                  image: widget.carte.image,
                                  prix: widget.carte.prix,
                                  tauxAugmentation:
                                      widget.carte.tauxAugmentation,
                                  niveau: widget.carte.niveau + 1,
                                  estAchete: widget.carte.estAchete,
                                  force: widget.carte.force,
                                  tauxAugmentationForce:
                                      widget.carte.tauxAugmentationForce))
                          .whenComplete(() {
                        Navigator.of(context).pop();
                      });
                    } catch (e) {
                      print("error: $e");
                    }
                  },
                );
              }
            },
          ),
        ],
      ),
    );
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

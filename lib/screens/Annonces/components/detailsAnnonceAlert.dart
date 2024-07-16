import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../widgets/bottomSheet_modal.dart';

class AnnonceDetailsAlert extends StatefulWidget {
  AnnonceDetailsAlert({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => AnnonceDetailsAlertState();
}

class AnnonceDetailsAlertState extends State<AnnonceDetailsAlert>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  final _formKey = GlobalKey<FormState>();
  bool remember = false;

  Color colors = const Color(0xffe7123b).withOpacity(0.8);

  //-------------------------------------------------------------//
  TextStyle style = TextStyle(fontFamily: 'Aller');

//##############################################//

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Center(
        child: Form(
          key: _formKey,
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: OrientationBuilder(builder: (context, orientation) {
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width < 400
                            ? MediaQuery.of(context).size.width * 0.9
                            : 380,
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 200,
                              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black87,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/img_back1.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height *
                                          0.65),
                              child: Scrollbar(
                                interactive: true,
                                trackVisibility: true,
                                thumbVisibility: true,
                                radius: const Radius.circular(10),
                                scrollbarOrientation:
                                    ScrollbarOrientation.right,
                                thickness: 2.0,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 10.0),
                                        child: Text(
                                          Information,
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: Colors.black,
                                              ),
                                        ),
                                      ),

                                      //--------------------------------//
                                      //Pour Particulier
                                      //--------------------------------//
                                      title(
                                          text:
                                              "Certification pour les Particuliers"),
                                      subTitle(text: "Comment ça marche ?"),
                                      content(
                                          index: "1",
                                          titre: "Soumettez vos Documents",
                                          contenu:
                                              "Les utilisateurs particuliers souhaitant être certifiés doivent fournir une pièce d'identité valide  en recto et verso."),
                                      content(
                                          index: "2",
                                          titre: "Vérification Rigoureuse",
                                          contenu:
                                              "Notre équipe dédiée effectuera une vérification approfondie pour assurer la validité de vos informations."),
                                      content(
                                          index: "3",
                                          titre: "Notification en Temps Réel ",
                                          contenu:
                                              "Soyez informé du statut de votre certification. En cas d'approbation, votre profil sera agrémenté d'un badge de confiance."),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      // --------------------------//
                      Positioned(top: 0, right: 0, child: closeIcon(context))
                      // ----------------------------//
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  String Information =
      "Nous comprenons l'importance de la confiance dans notre communauté, c'est pourquoi nous proposons un processus de certification de compte transparent et adapté à vos besoins, que vous soyez un particulier ou une entreprise.";

  title({required String text}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Color3, fontWeight: FontWeight.w600),
          ),
        ),
      );

  subTitle({required String text}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      );

  content(
          {required String index,
          required String titre,
          required String contenu}) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AutoSizeText.rich(
            TextSpan(text: '$index. ', children: [
              TextSpan(
                text: "$titre : ",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: contenu,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
            ]),
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.black, fontSize: 13),
            minFontSize: 12,
          ),
        ),
      );
}

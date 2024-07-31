import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class RevenuDetails_PopUp extends StatefulWidget {
  RevenuDetails_PopUp({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => RevenuDetails_PopUpState();
}

class RevenuDetails_PopUpState extends State<RevenuDetails_PopUp>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  //-------------------------------------------------------------//
  TextStyle style = TextStyle(fontFamily: 'Aller');

//##############################################//

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    scaleAnimation = CurvedAnimation(
        parent: controller, curve: Curves.easeInOutCubicEmphasized);

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
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: OrientationBuilder(builder: (context, orientation) {
              return Stack(children: [
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.7),
                        child: Scrollbar(
                          interactive: true,
                          trackVisibility: true,
                          thumbVisibility: true,
                          radius: const Radius.circular(10),
                          scrollbarOrientation: ScrollbarOrientation.right,
                          thickness: 2.0,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  child: Text(
                                    "Gandalverse valorise sa communauté en reversant une commission aux membres actifs. Plus vous vous engagez, plus vous gagnez ! Devenez éligible en invitant vos amis et débloquez des récompenses incroyables.",
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
                                title(text: "Formule de redistribution"),
                                subTitle(text: "Comment ça marche ?"),
                                content(
                                    index: "1",
                                    titre: "Commission totale (CT)",
                                    contenu: "Montant total à redistribuer."),
                                content(
                                    index: "2",
                                    titre: "Membres éligibles (X)",
                                    contenu:
                                        "Nombre de membres ayant rempli les critères."),
                                content(
                                    index: "3",
                                    titre: "Niveau d'engagement (NE) ",
                                    contenu:
                                        "Basé sur le nombre d'amis invités."),
                                //Détails Etapes
                                title(text: "Étapes"),
                                content(
                                    index: "1",
                                    titre:
                                        "Déterminer le niveau d'engagement (NE)",
                                    contenu: " "),
                                subTitle2(
                                    text: "- Si amis invités < 20 : NE = 0"),
                                subTitle2(
                                    text:
                                        "- Si 20 ≤ amis invités < 100 : NE = 1"),
                                subTitle2(
                                    text:
                                        "- Si 100 ≤ amis invités < 1000 : NE = 2"),
                                subTitle2(
                                    text: "- Si amis invités ≥ 1000 : NE = 3"),
                                content(
                                    index: "2",
                                    titre:
                                        "Calculer la part de chaque membre (PM) ",
                                    contenu: " "),
                                subTitle2(
                                    text: "- PM = CT / (X * 3) pour NE = 3"),
                                subTitle2(
                                    text: "- PM = CT / (X * 2) pour NE = 2"),
                                subTitle2(
                                    text: "- PM = CT / (X * 1) pour NE = 1"),
                                subTitle2(text: "- PM = 0 pour NE = 0"),

                                // content(index: "3", titre: " ", contenu: " "),

                                //Exemple
                                subTitle(text: ""),
                                title(text: "Exemple de redistribution"),

                                content(
                                    index: "-",
                                    titre: "CT = 1 000 000 FCFA",
                                    contenu: " "),
                                content(
                                    index: "-",
                                    titre: "Membres ",
                                    contenu: "Mamadou, Fatou, Penda"),

                                //Etape calcul
                                title(text: "Étapes de calcul :"),
                                content(
                                    index: "1",
                                    titre: "Total des parts (TP)",
                                    contenu: " "),
                                subTitle2(text: "- Mamadou : 3 parts"),
                                subTitle2(text: "- Fatou : 2 parts"),
                                subTitle2(text: "- Penda : 1 part"),

                                subTitle2(
                                    text: "TP = 3 + 2 + 1 = 6 parts",
                                    toBold: true),
                                subTitle(text: ""),
                                //Calcul de la part de chaque membre
                                content(
                                    index: "2",
                                    titre:
                                        "Calcul de la part de chaque membre (PM)",
                                    contenu: ""),
                                subTitle2(
                                    text: "-- Pour Mamadou (NE = 3) :",
                                    toBold: true),
                                subTitle2(
                                    text:
                                        "- PM (Mamadou) = 1 000 000 / 6 × 3 = 500 000 FCFA"),
                                subTitle2(
                                    text: "-- Pour Fatou (NE = 2) :",
                                    toBold: true),
                                subTitle2(
                                    text:
                                        "- PM (Fatou) = 1 000 000 / 6 × 2 = 333 333,33 FCFA"),
                                subTitle2(
                                    text: "-- Pour Penda (NE = 1) :",
                                    toBold: true),
                                subTitle2(
                                    text:
                                        "- PM (Penda) = 1 000 000 / 6 × 1 = 166 666,67 FCFA"),

                                //Résumé des parts
                                title(text: "Résumé des parts"),
                                content(
                                    index: "",
                                    titre: "Mamadou",
                                    contenu: "500 000 FCFA"),
                                content(
                                    index: "",
                                    titre: "Fatou",
                                    contenu: "333 333,33 FCFA"),
                                content(
                                    index: "",
                                    titre: "Penda",
                                    contenu: "166 666,67 FCFA"),
                                //--------------------------------//
                                //--------------------------------//
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

                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: (() => Navigator.of(context).pop()),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(width: 1.5, color: Colors.white),
                      ),
                      child: Center(
                        child: Icon(Icons.close, color: Color3),
                      ),
                    ),
                  ),
                )
                // ----------------------------//
              ]);
            }),
          ),
        ),
      ),
    );
  }

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

  subTitle({required String text, bool toBold = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontWeight: toBold ? FontWeight.normal : FontWeight.w500),
          ),
        ),
      );

  subTitle2({required String text, bool toBold = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.black,
                fontWeight: toBold ? FontWeight.w500 : FontWeight.normal),
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

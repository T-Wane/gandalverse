import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/core/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class NiveauxDetails_PopUp extends StatefulWidget {
  NiveauxDetails_PopUp({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => NiveauxDetails_PopUpState();
}

class NiveauxDetails_PopUpState extends State<NiveauxDetails_PopUp>
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
                                MediaQuery.of(context).size.height * 0.8),
                        child: Scrollbar(
                          interactive: true,
                          trackVisibility: true,
                          thumbVisibility: true,
                          radius: const Radius.circular(10),
                          scrollbarOrientation: ScrollbarOrientation.right,
                          thickness: 2.0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //--------------------------------//
                              CustomImageView(
                                imagePath: Images.logo_black,
                                fit: BoxFit.contain,
                                height: 80,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: AutoSizeText(
                                  'Différents Niveaux',
                                  maxLines: 1,
                                  minFontSize: 20,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Color3,
                                      fontFamily: "Aller"),
                                ),
                              ),
                              content(
                                  index: 'Niv 1', titre: 'Œuf', coins: '25k'),
                              content(
                                  index: 'Niv 2',
                                  titre: 'Œuf commence à éclore',
                                  coins: '25k'),
                              content(
                                  index: 'Niv 3',
                                  titre: 'Le petit aigle sort en fin',
                                  coins: '25k'),
                            ],
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

  content(
          {required String index,
          required String titre,
          required String coins}) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                index,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Color3,
                    fontFamily: "Aller",
                    fontSize: 12),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  titre,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Color3,
                      fontFamily: "Aller",
                      fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomImageView(
                      imagePath: Images.gvt,
                      fit: BoxFit.contain,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 5),
                    AutoSizeText(
                      coins,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color3,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

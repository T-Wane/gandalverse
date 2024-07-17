import 'package:flutter/material.dart';

class ElementCard extends StatelessWidget {
  ElementCard({
    Key? key,
    required this.title,
    required this.titleColor,
    required this.SubWidget,
    required this.backColors,
    required this.leadingWidget,
    this.press,
  }) : super(key: key);

  final String title;
  final Widget SubWidget;
  final Widget leadingWidget;
  final VoidCallback? press;
  final Color titleColor;
  final List<Color> backColors;

  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(vertical: 5, horizontal: 5),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: backColors),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: Color3.withOpacity(0.1),
            offset: Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: press as void Function()?,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 2, vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  leadingWidget,
                  /* Container(
                    height: 50,
                    width: 60,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black87,
                      image: const DecorationImage(
                        image: AssetImage("assets/images/img_back1.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Aller',
                          color: Color3,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SubWidget
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

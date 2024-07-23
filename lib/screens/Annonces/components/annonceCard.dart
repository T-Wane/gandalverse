import 'package:flutter/material.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class AnnonceCard extends StatelessWidget {
  AnnonceCard({
    Key? key,
    required this.title,
    required this.titleColor,
    required this.text,
    required this.textColor,
    required this.backColors,
    required this.imagePath,
    this.fit = BoxFit.cover,
    this.press,
  }) : super(key: key);

  final String title, text;
  final String imagePath;
  final VoidCallback? press;
  final Color titleColor, textColor;
  final List<Color> backColors;
  final BoxFit fit;

  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return /*Container(
      margin: const EdgeInsetsDirectional.symmetric(vertical: 5, horizontal: 5),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: backColors),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: Colors.blueAccent.shade100.withOpacity(0.1),
            offset: const Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: */

        Card(
      clipBehavior: Clip.antiAlias,
      borderOnForeground: false,
      shadowColor: Colors.blueAccent.shade100,
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
      ),
      margin: const EdgeInsets.all(5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
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
                    CustomImageView(
                      imagePath: imagePath,
                      height: 50,
                      width: 50,
                      fit: fit,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      radius: BorderRadius.circular(10),
                    ),
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Aller',
                            color: Color3.withOpacity(0.9),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              text,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    this.limitLine = true,
    this.press,
  }) : super(key: key);

  final String title, text;
  final String imagePath;
  final VoidCallback? press;
  final Color titleColor, textColor;
  final List<Color> backColors;
  final BoxFit fit;
  final bool limitLine;

  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      height: 40,
                      width: 40,
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
                              maxLines: limitLine ? 2 : null,
                              overflow:
                                  limitLine ? TextOverflow.ellipsis : null,
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

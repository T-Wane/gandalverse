import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class infoItem extends StatelessWidget {
  String titre, data;
  bool showCopy;
  Color dataColor;
  infoItem(
      {super.key,
      required this.titre,
      required this.data,
      this.dataColor = Colors.white,
      this.showCopy = false});

  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: AutoSizeText(
                titre,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color3,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  fontFamily: 'Aller',
                ),
              ),
            ),
            Expanded(
              child: RichText(
                textAlign: TextAlign.end,
                text: TextSpan(
                  text: '$data  ',
                  children: [
                    if (showCopy == true) ...[
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () => FlutterClipboard.copy(data).then(
                            (value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  "Code Copié",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Aller',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                elevation: 1.0,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                dismissDirection: DismissDirection.horizontal,
                                backgroundColor: Colors.grey.shade400,
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.copy,
                            size: 22,
                            color: Colors.deepPurple.shade400,
                          ),
                        ),
                      ),
                    ]
                  ],
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Aller",
                      fontWeight: FontWeight.w500,
                      color: dataColor),
                ),
              ),
            ),
          ]),
    );
  }
}

//----------------------------------------//

class infoItem2 extends StatelessWidget {
  String titre, data;
  Color dataColor;
  bool toEnd;
  infoItem2(
      {super.key,
      required this.titre,
      required this.data,
      this.dataColor = Colors.white,
      this.toEnd = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AutoSizeText(
                titre,
                textAlign: toEnd ? TextAlign.end : TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  fontFamily: 'Aller',
                ),
              ),
            ),
            Expanded(
              child: RichText(
                textAlign: toEnd ? TextAlign.end : TextAlign.start,
                text: TextSpan(
                  text: '$data  ',
                  children: [],
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: "Aller",
                      fontWeight: FontWeight.w500,
                      color: dataColor),
                ),
              ),
            ),
          ]),
    );
  }
}

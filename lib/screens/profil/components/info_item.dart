
import 'package:auto_size_text/auto_size_text.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: AutoSizeText(
                titre,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
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

                  ],
                  style: TextStyle(
                      fontSize: 13.5,
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
  infoItem2({
    super.key,
    required this.titre,
    required this.data,
    this.dataColor = Colors.white,
    this.toEnd=  false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: AutoSizeText(
                titre,
                textAlign:toEnd?TextAlign.end: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  fontFamily: 'Aller',
                ),
              ),
            ),
            Expanded(
              child: RichText(
                textAlign: toEnd?TextAlign.end: TextAlign.start,
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

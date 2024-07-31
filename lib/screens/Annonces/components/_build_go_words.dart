import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/screens/Annonces/components/annonceCard.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';

import 'go_words_game.dart';

class buildGoWords extends StatelessWidget {
  buildGoWords({
    super.key,
    required this.Color3,
  });

  final Color Color3;
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AnnonceCard(
        title: 'Go Words',
        text: 'Trouver le mot caché dans le Monde virtuel',
        imagePath: Images.word,
        backColors: const [
          Colors.white,
          Colors.white,
        ],
        fit: BoxFit.contain,
        press: () {
          CardContentBottomSheet.show(context,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Go Words",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          color: Color3,
                          fontFamily: "Aller",
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla non tincidunt odio. Nunc id tellus lectus.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Color3.withOpacity(0.95),
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
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
                        const SizedBox(
                          width: 5,
                        ),
                        AutoSizeText(
                          '205 000',
                          maxLines: 1,
                          presetFontSizes: [22, 20, 18, 15, 14],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomWidgets.textField('Le Mot',
                        textController: textController),
                    // Game(
                    //   word: "FLUTTER",
                    //   isEasy: false,
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    DefaultButton(
                      backColor: Colors.purple.shade400,
                      text: 'Verifier',
                      elevation: 1.0,
                      textColor: Colors.white,
                      fontSize: 15,
                      height: 50,
                      press: () {},
                    )
                  ],
                ),
              ),
              fit: BoxFit.contain,
              setCircle: false,
              image: Images.word);
        },
        textColor: Colors.black,
        titleColor: Color3);
  }
}

class CustomWidgets {
  static Widget textField(String title,
      {bool isPassword = false,
      bool isNumber = false,
      int? length,
      required TextEditingController textController,
      int lines = 1}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 2,
          ),
          TextFormField(
            maxLines: lines,
            controller: textController,
            maxLength: length,
            inputFormatters: [
              LengthLimitingTextInputFormatter(length),
            ],
            obscureText: isPassword,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          )
        ],
      ),
    );
  }
}

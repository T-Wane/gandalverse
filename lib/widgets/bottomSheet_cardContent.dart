import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/carte.dart';
import 'package:gandalverse/widgets/customImageView.dart';

import 'bottomSheet_modal.dart';

class CardContentBottomSheet extends StatelessWidget {
  static void show(BuildContext context,
          {Key? key,
          required Widget child,
          required String image,
          bool setCircle = true,
          Color backColor = Colors.white,
          BoxFit fit = BoxFit.cover,
          bool isDismissible = true}) =>
      showModalBottomSheet(
        enableDrag: true,
        isScrollControlled: true,
        isDismissible: isDismissible,
        context: context,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(15),
            topStart: Radius.circular(15),
          ),
        ),
        builder: (context) => Stack(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(top: 100),
            decoration: BoxDecoration(
                color: Colors.purpleAccent.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.purpleAccent.withOpacity(0.5),
                      offset: const Offset(1, 1),
                      blurRadius: 10,
                      spreadRadius: 4)
                ]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: backColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: CardContentBottomSheet(
                  key: key,
                  image: image,
                  child: child,
                ),
              ),
            ),
          ),
          //---------------//
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color3.withOpacity(0.1),
                ),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purpleAccent.withOpacity(0.1),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purpleAccent.withOpacity(0.1),
                    ),
                    child: CustomImageView(
                      imagePath: image,
                      height: 150,
                      width: 150,
                      radius: setCircle ? BorderRadius.circular(75) : null,
                      fit: fit,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  CardContentBottomSheet({Key? key, required this.image, required this.child})
      : super(key: key);

  String image;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Align(
              alignment: Alignment.centerRight, child: closeIcon(context))),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        child: Divider(
          color: Colors.grey.shade200,
        ),
      ),
      Flexible(child: child)
    ]);
  }
}

import 'package:flutter/material.dart';

const Color3 = Color.fromARGB(255, 18, 40, 70);

class CustomBottomModalSheet extends StatelessWidget {
  static void show(BuildContext context,
          {Key? key,
          required Widget child,
          required String titre,
          bool isDismissible = true}) =>
      showModalBottomSheet(
        enableDrag: true,
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.5,
            maxHeight: MediaQuery.of(context).size.height * 0.9),
        isScrollControlled: true,
        isDismissible: isDismissible,
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(15),
            topStart: Radius.circular(15),
          ),
        ),
        builder: (context) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(5),
          color: Colors.white,
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: CustomBottomModalSheet(
              key: key,
              titre: titre,
              child: child,
            ),
          ),
        ),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  CustomBottomModalSheet({Key? key, required this.titre, required this.child})
      : super(key: key);

  String titre;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              titre,
              maxLines: 1,
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 17,
                  color: Color3,
                  fontFamily: "Aller",
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        closeIcon(context)
      ]),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        child: Divider(
          color: Colors.grey.shade200,
        ),
      ),
      child
    ]);
  }
}

GestureDetector closeIcon(BuildContext context, {Function? press}) =>
    GestureDetector(
      onTap: press != null
          ? press as void Function()?
          : () => Navigator.of(context).pop(),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(width: 1.5, color: Colors.white),
        ),
        child: const Center(
          child: Icon(Icons.close, color: Color3),
        ),
      ),
    );

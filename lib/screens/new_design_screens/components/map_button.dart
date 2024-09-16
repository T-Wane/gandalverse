import 'package:flutter/material.dart';
import 'package:gandalverse/screens/new_design_screens/helper/ui_helper.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class MapButton extends StatelessWidget {
  final double bottom;
  final double offsetX;
  final double width;
  final double height;

  final String? title;

  final String? image;
  final IconData? icon;
  Color? iconColor;
  final bool isRight;
  Gradient? gradient;

  final Function? press;

  MapButton(
      {Key? key,
      required this.bottom,
      required this.offsetX,
      required this.width,
      required this.height,
      required this.icon,
      this.title,
      this.image,
      this.iconColor,
      this.isRight = true,
      this.gradient,
      this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: realH(bottom),
        left: !isRight ? realW(offsetX) : null,
        right: isRight ? realW(offsetX) : null,
        child: PointerInterceptor(
          debug: false,
          child: GestureDetector(
            onTap: press as void Function()?,
            child: Container(
                width: realW(width),
                height: realH(height),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: realW(17)),
                decoration: BoxDecoration(
                    color: gradient == null ? Colors.white : null,
                    gradient: gradient,
                    borderRadius: isRight
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(realW(36)),
                            topLeft: Radius.circular(realW(36)))
                        : BorderRadius.only(
                            bottomRight: Radius.circular(realW(36)),
                            topRight: Radius.circular(realW(36))),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          blurRadius: realW(36)),
                    ]),
                child: Column(
                  children: [
                    image != null
                        ? CustomImageView(
                            imagePath: image,
                            fit: BoxFit.contain,
                            width: realW(28),
                            height: realW(28),
                          )
                        : Icon(
                            icon,
                            size: realW(28),
                            color: iconColor ?? Colors.black,
                          ),
                    if (title != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        title ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Themecolors.Color3,
                            fontFamily: "Aller",
                            fontSize: 8),
                      )
                    ]
                  ],
                )),
          ),
        ));
  }
}

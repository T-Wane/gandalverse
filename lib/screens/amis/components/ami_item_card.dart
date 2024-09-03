import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class AmiItemCard extends StatefulWidget {
  AmiItemCard({super.key, required this.friend});
  UserModel friend;

  @override
  State<AmiItemCard> createState() => _AmiItemCardState();
}

class _AmiItemCardState extends State<AmiItemCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: InkWell(
        onTap: () {},
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.shade100,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.all(2),
                    child: CustomImageView(
                      imagePath: widget.friend.photoUrl ??
                          "assets/images/new/avatar.png",
                      height: 40,
                      width: 40,
                      radius: BorderRadius.circular(20),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "${widget.friend.firstName ?? ''} ${widget.friend.lastName ?? ''} ",
                      minFontSize: 12,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Themecolors.Color3.withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Aller',
                      ),
                    ),
                    AutoSizeText(
                      '---',
                      minFontSize: 10,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 11,
                        color: Themecolors.Color3.withOpacity(0.8),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Aller',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Themecolors.Color3.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "niveau",
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: "Aller",
                      color: Themecolors.Color3),
                ),
              )
            ]),
      ),
    );
  }
}

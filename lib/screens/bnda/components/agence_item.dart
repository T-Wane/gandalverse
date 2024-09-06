import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/screens/bnda/modeles/agence.dart';
import 'package:gandalverse/screens/profil/components/infoLigne.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class AgenceItem extends StatelessWidget {
  AgenceItem(
      {super.key,
      required this.index,
      required this.agence,
      required this.zoomOn});
  int index;
  Agence agence;
  Future<void> Function(Agence agence) zoomOn;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await zoomOn(agence);
      },
      child: Card(
        elevation: 1.0,
        surfaceTintColor: Colors.transparent,
        color: Themecolors.ColorWhite,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          leading: CircleAvatar(
            backgroundColor: Themecolors.Color3,
            child: CustomImageView(
              imagePath: Images.ticket_box,
              fit: BoxFit.contain,
              height: 40,
            ),
          ),
          title: Text(
            agence.designation ?? "",
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Themecolors.greyDeep,
                fontFamily: "Aller"),
          ),
          subtitle: Column(
            children: [
              detailsLigne(
                paddingV: 2,
                titre: "Tèl:",
                data: agence.phone ?? '--',
                nLigne: 1,
                dataColor: Themecolors.greyDeep,
              ),
              detailsLigne(
                paddingV: 2,
                titre: "Adresse",
                data: agence.adresse ?? '--',
                nLigne: 1,
                dataColor: Themecolors.greyDeep,
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              CardContentBottomSheet.show(context,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          agence.designation ?? '--',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Themecolors.greyDeep,
                              fontFamily: "Aller",
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        AutoSizeText(
                          agence.information ?? '--',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                color: Themecolors.greyDeep.withOpacity(0.95),
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                        detailsLigne(
                          paddingV: 2,
                          titre: "Adresse",
                          data: agence.adresse ?? '--',
                          nLigne: 1,
                          dataColor: Themecolors.greyDeep,
                        ),
                        detailsLigne(
                          paddingV: 2,
                          titre: "Distance",
                          data: '2 Km',
                          nLigne: 1,
                          dataColor: Themecolors.greyDeep,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          " Tel : +223 xx-xx-xx-xx",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Themecolors.greyDeep,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Ouvert : OUI",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Themecolors.greyDeep,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DefaultButton(
                          backColor: Themecolors.Color3,
                          text: 'Contacter',
                          elevation: 1.0,
                          textColor: Colors.white,
                          fontSize: 15,
                          height: 40,
                          press: () {},
                        )
                      ],
                    ),
                  ),
                  fit: BoxFit.contain,
                  setCircle: false,
                  image: Images.ticket_box);
            },
            icon: const Icon(
              CupertinoIcons.info,
              size: 20,
              color: Themecolors.greyDeep,
            ),
          ),
        ),
      ),
    );
  }
}

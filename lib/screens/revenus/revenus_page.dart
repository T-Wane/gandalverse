import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/rounded_btn_back.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/data/telegram_client.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/screens/revenus/data/revenus_data.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

import '../../components/user_top_infos.dart';
import '../../themes/images/appImages.dart';
import '../defis/components/annonceCard.dart';
import 'components/plus_details_btn.dart';

// Classe concrète pour l'événement "contactRequested"
class ContactRequestedEvent extends TelegramEvent {
  ContactRequestedEvent(Function eventHandler)
      : super(TelegramEventType.contactRequested, eventHandler);
}

class AllRevenusPage extends StatefulWidget {
  const AllRevenusPage({super.key});

  @override
  State<AllRevenusPage> createState() => _AllRevenusPageState();
}

class _AllRevenusPageState extends State<AllRevenusPage> {
  Color Color3 = const Color.fromARGB(255, 18, 40, 70);

  TelegramClient _telegramClient = getIt<TelegramClient>();

  UserProvider _userProvider = getIt<UserProvider>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      // _telegramClient.telegram.requestContact();
       _telegramClient.telegram.onEvent(ContactRequestedEvent(onEvent));
       
    });
  }*/

    // Fonction pour gérer les événements Telegram
    _telegramClient.telegram.onEvent(
        ContactRequestedEvent(onEvent)); // Configurez l'écoute des événements
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //  requestContact();
    });
  }

  // Méthode pour gérer les événements
  void onEvent(TelegramEvent event) {
    print('Event received: ${event.eventType}');
    print('Event received: ${event.eventType.eventName}');

    // Traitez l'événement ici
    if (event.eventType == TelegramEventType.contactRequested) {
      // Traitement pour les contacts demandés
      final contact = event.eventHandler as Map<String, dynamic>;
      final phoneNumber = contact['phone_number'];
      final firstName = contact['first_name'];
      final lastName = contact['last_name'];
      print('Contact reçu: $phoneNumber, $firstName $lastName');
    }
  }

  void requestContact() {
    _telegramClient.telegram.showPopup(
      title: 'Partager votre contact',
      message: 'Veuillez partager votre contact avec nous.',
      buttons: [
        PopupButton.defaultType('share_contact', 'Partager le contact'),
        PopupButton.cancel('Annuler'),
      ],
      callback: (String id) {
        if (id == 'share_contact') {
          print('L\'utilisateur a choisi de partager le contact');
          _telegramClient.telegram.requestContact();
        } else if (id == 'cancel') {
          print('L\'utilisateur a annulé');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.all(5.0),
        child: Column(children: [
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Padding(
          //     padding: const EdgeInsets.all(5.0),
          //     child: BtnRoundedIconBack(
          //       couleur: Themecolors.Color3,
          //       onpress: () {
          //         Navigator.of(context).pop();
          //       },
          //     ),
          //   ),
          // ),
          userTopInfos(
            showBackArrow: true,
          ),
          Flexible(
            child: ListView(children: [
              CustomImageView(
                imagePath: Images.gvtWithLight,
                fit: BoxFit.contain,
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: AutoSizeText(
                  'Gagner comme jamais',
                  maxLines: 1,
                  minFontSize: 20,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25, color: Color3, fontFamily: "Aller"),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.all(5.0),
                child: AutoSizeText(
                  'Suivez les revenus générés par la publicité et découvrez comment ils sont redistribués',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Color3.withOpacity(0.7)),
                ),
              ),*/
              subTitle(
                  text:
                      "Gandalverse valorise sa communauté en reversant une commission aux membres actifs. Plus vous vous engagez, plus vous gagnez ! Devenez éligible en invitant vos amis et débloquez des récompenses incroyables :"),
              _buildEligibilites,
              plusDetailsBtn(Color3: Color3),
              AnnonceCard(
                  title: panneauxData['title']!,
                  text: panneauxData['content']!,
                  limitLine: true,
                  imagePath: Images.pub,
                  backColors: [
                    Color3.withOpacity(0.2),
                    Color3.withOpacity(0.5),
                    Color3.withOpacity(0.8),
                    Color3,
                  ],
                  fit: BoxFit.contain,
                  press: () {},
                  textColor: Colors.black,
                  titleColor: Color3),
              /* AnnonceCard(
                  title: 'Panneaux',
                  text:
                      'Voir les panneaux disponibles et ceux qui sont loués avec les revenus générés',
                  imagePath: Images.panneaux,
                  backColors: const [
                    Colors.white,
                    Colors.white,
                  ],
                  fit: BoxFit.contain,
                  press: () {},
                  textColor: Colors.black,
                  titleColor: Color3),
              AnnonceCard(
                  title: 'Redistribution',
                  text:
                      'Suivre comment les revenus sont redistribués aux utilisateurs actifs',
                  imagePath: Images.redistribuer,
                  backColors: const [
                    Colors.white,
                    Colors.white,
                  ],
                  fit: BoxFit.contain,
                  press: () {},
                  textColor: Colors.black,
                  titleColor: Color3),*/
              AnnonceCard(
                  title: 'AirDrop',
                  text: 'Airdrop du token GVT à venir',
                  imagePath: Images.gvtWithLight,
                  backColors: const [
                    Colors.white,
                    Colors.white,
                  ],
                  fit: BoxFit.contain,
                  press: () {},
                  textColor: Colors.black,
                  titleColor: Color3),
              const SizedBox(
                height: 100,
              )
            ]),
          ),
        ]),
      ),
    );
  }

  //-----------------------------------------------//
  title({required String text}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Color3, fontWeight: FontWeight.w600),
          ),
        ),
      );

  subTitle({required String text}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Color3.withOpacity(0.8), fontWeight: FontWeight.normal),
          ),
        ),
      );

  Padding content(
          {required String index,
          required String titre,
          required String contenu}) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 10,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AutoSizeText.rich(
            TextSpan(text: '$index ', children: [
              TextSpan(
                text: "$titre : ",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color3,
                    fontFamily: "Aller"),
              ),
              TextSpan(
                text: contenu,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color3.withOpacity(0.9),
                ),
              ),
            ]),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color3,
              fontSize: 13,
            ),
            minFontSize: 12,
          ),
        ),
      );

  Column get _buildEligibilites => Column(
        children: eligibilitesData
            .map(
              (e) => content(
                index: e['index'],
                titre: e['title'],
                contenu: e['content'],
              ),
            )
            .toList(),
      );
}

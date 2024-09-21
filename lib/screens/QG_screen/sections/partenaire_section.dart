import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/core/services/QG_services/extension/carteService_extension.dart';
import 'package:gandalverse/core/services/QG_services/partenaire_service.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:provider/provider.dart';

import '../components/cardUpdateWidget.dart';
import '../components/carteCard.dart';

class PartenaireSection extends StatefulWidget {
  @override
  _PartenaireSectionState createState() => _PartenaireSectionState();
}

class _PartenaireSectionState extends State<PartenaireSection> {
  late Future<List<CarteModel>> _partenaireDataFuture;
  PartenaireService _partenaireService = getIt<PartenaireService>();
  final ScrollController _partenaireScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //_partenaireService.loadInitialData();
    // Écoute du stream pour les mises à jour des données
    _partenaireService.partenaireStream.listen((dataList) {
      setState(() {
        // _equipeService.loadInitialData();
        // Mise à jour de l'interface utilisateur avec les nouvelles données
      });
    });
  }

  @override
  Widget build(BuildContext context) {
       final screen_size_width = MediaQuery.of(context).size.width;
    final screen_size_height = MediaQuery.of(context).size.height;
    // Calculer la largeur de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    // Définir une largeur fixe pour chaque carte
    final cardWidth = 180.0;
    // Calculer le nombre de colonnes basé sur la largeur de l'écran
    _partenaireService.loadInitialData();
    return Consumer<UserProvider>(builder: (context, _userProvider, child) {
      return Stack(children: [
        StreamBuilder<List<CarteModel>>(
          stream: _partenaireService.partenaireStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur : ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Aucune donnée disponible'));
            } else {
              final partenaireList = snapshot.data!;

              final niveauUtilisateur = _userProvider.user?.level;
              final cartesPossedees =
                  BuiltList<String>(_userProvider.getPurchaseCardsIds());
              final niveauxCartesPossedees = BuiltMap<String, int>(
                  _userProvider.getPurchaseCardsLevelAndId());
              final profitParHeure = _userProvider.user?.profitPerHour;
              final codeSaisi = '';
              final nombreAmis = _userProvider.user?.friends?.length ?? 0;

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GridView.builder(
                    controller: _partenaireScrollController,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 20),
                    // physics: const NeverScrollableScrollPhysics(),
                    // gridDelegate:
                    //     const SliverGridDelegateWithMaxCrossAxisExtent(
                    //   maxCrossAxisExtent: 180,
                    //   mainAxisExtent: 200,
                    //   crossAxisSpacing: 1,
                    //   mainAxisSpacing: 1,
                    // ),
                     gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisExtent: 200,
                              // childAspectRatio:
                              //     cardWidth / 100, // Ratio largeur/hauteur
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                            ),
                    itemCount: partenaireList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      CarteModel carte = partenaireList[index];

                      final contrainteMessage =
                          _partenaireService.getContrainteVerrouillage(
                        carte,
                        niveauUtilisateur: niveauUtilisateur ?? 0,
                        cartesPossedees: cartesPossedees,
                        niveauxCartesPossedees: niveauxCartesPossedees,
                        profitParHeure: profitParHeure ?? 0.0,
                        codeSaisi: codeSaisi,
                        nombreAmis: nombreAmis,
                      );
                      return CarteCard(
                        carte: carte,
                        qgService: _partenaireService,
                        isUnlocked: contrainteMessage == null,
                        contrainteMessage: contrainteMessage,
                      );
                    }),
              );
            }
          },
        ),
        // CardUpdateWidget(
        //   service: _partenaireService,
        // )
      ]);
    });
  }
}

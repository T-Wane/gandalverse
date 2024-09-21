import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:gandalverse/core/providers/user_provider.dart';
import 'package:gandalverse/core/services/QG_services/equipe_service.dart';
import 'package:gandalverse/core/services/QG_services/extension/carteService_extension.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:provider/provider.dart';

import '../components/cardUpdateWidget.dart';
import '../components/carteCard.dart';

class EquipeSection extends StatefulWidget {
  @override
  _EquipeSectionState createState() => _EquipeSectionState();
}

class _EquipeSectionState extends State<EquipeSection> {
  late Future<List<CarteModel>> _equipeDataFuture;
  EquipeService _equipeService = getIt<EquipeService>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _equipeService.loadInitialData();
    // Écoute du stream pour les mises à jour des données
    _equipeService.equipeStream.listen((dataList) {
      setState(() {
        // _equipeService.loadInitialData();
        // Mise à jour de l'interface utilisateur avec les nouvelles données
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _equipeService.loadInitialData();
    return Consumer<UserProvider>(builder: (context, _userProvider, child) {
      return Stack(
        children: [
          StreamBuilder<List<CarteModel>>(
            stream: _equipeService.equipeStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur : ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Aucune donnée disponible'));
              } else {
                final equipeList = snapshot.data!;

                final niveauUtilisateur = _userProvider.user?.level;
                final cartesPossedees =
                    BuiltList<String>(_userProvider.getPurchaseCardsIds());
                final niveauxCartesPossedees = BuiltMap<String, int>(
                    _userProvider.getPurchaseCardsLevelAndId());
                final profitParHeure = _userProvider.user?.profitPerHour;
                final codeSaisi = '';
                final nombreAmis = _userProvider.friends.isNotEmpty
                    ? _userProvider.friends.length
                    : _userProvider.user?.friends?.length ?? 0;

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GridView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 20),
                      //physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 180,
                        mainAxisExtent: 200,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      itemCount: equipeList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        CarteModel carte = equipeList[index];

                        final contrainteMessage =
                            _equipeService.getContrainteVerrouillage(
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
                          qgService: _equipeService,
                          isUnlocked: contrainteMessage == null,
                          contrainteMessage: contrainteMessage,
                        );
                      }),
                );
              }
            },
          ),
          // CardUpdateWidget(
          //   service: _equipeService,
          // )
        ],
      );
    });
  }
}

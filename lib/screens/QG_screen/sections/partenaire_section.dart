import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:gandalverse/core/services/QG_services/partenaire_service.dart';
import 'package:gandalverse/di/global_dependencies.dart';

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
    _partenaireService.loadInitialData();
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
    _partenaireService.loadInitialData();
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

            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: GridView.builder(
                  controller: _partenaireScrollController,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 20),
                  // physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 180,
                    mainAxisExtent: 200,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemCount: partenaireList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    CarteModel carte = partenaireList[index];
                    return CarteCard(
                        carte: carte, qgService: _partenaireService);
                  }),
            );
          }
        },
      ),
      CardUpdateWidget(
        service: _partenaireService,
      )
    ]);
  }
}

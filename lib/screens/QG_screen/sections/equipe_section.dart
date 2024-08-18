import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:gandalverse/core/services/QG_services/equipe_service.dart';
import 'package:gandalverse/di/global_dependencies.dart';

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
    _equipeService.loadInitialData();
  }

  @override
  void didUpdateWidget(covariant EquipeSection oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
   _equipeService.loadInitialData();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _equipeService.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    // _equipeService.loadItems();
    return StreamBuilder<List<CarteModel>>(
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

          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: GridView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 20),
                //physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  mainAxisExtent: 200,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemCount: equipeList.length,
                itemBuilder: (BuildContext ctx, index) {
                  CarteModel carte = equipeList[index];
                  return CarteCard(carte: carte, qgService: _equipeService);
                }),
          );
        }
      },
    );
  }
}

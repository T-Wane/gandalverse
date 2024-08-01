import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/carte.dart';
import 'package:gandalverse/core/services/equipe_service.dart';

import '../components/carteCard.dart';

class EquipeSection extends StatefulWidget {
  @override
  _EquipeSectionState createState() => _EquipeSectionState();
}

class _EquipeSectionState extends State<EquipeSection> {
  late Future<List<Carte>> _equipeFuture;
  final EquipeService _equipeService = EquipeService();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _equipeFuture = _equipeService.loadEquipes();
  }

  @override
  void didUpdateWidget(covariant EquipeSection oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _equipeFuture = _equipeService.loadEquipes();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _equipeFuture = _equipeService.loadEquipes();
  }

  @override
  Widget build(BuildContext context) {
    _equipeFuture = _equipeService.loadEquipes();
    return StreamBuilder<List<Carte>>(
      stream: _equipeService.equipeStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Aucune donnée disponible'));
        } else {
          final equipeList = snapshot.data!;
         
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: GridView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 100),
                // physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  mainAxisExtent: 180,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemCount: equipeList.length,
                itemBuilder: (BuildContext ctx, index) {
                  Carte carte = equipeList[index];
                  return CarteCard(carte: carte, equipeService: _equipeService);
                }),
          );
          /* ListView.builder(
              itemCount: equipeList.length,
              itemBuilder: (context, index) {
                final Carte = equipeList[index];
                return ListTile(
                  leading: Image.asset(Carte.image),
                  title: Text(Carte.nom),
                  subtitle: Text(Carte.description),
                );
              },
            );*/
        }
      },
    );
  }
}

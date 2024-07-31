import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/carte.dart';
import 'package:gandalverse/core/services/equipe_service.dart';
 
class EquipeSection extends StatefulWidget {
  @override
  _EquipeSectionState createState() => _EquipeSectionState();
}

class _EquipeSectionState extends State<EquipeSection> {
  late Future<List<Carte>> _equipeFuture;
  final EquipeService _equipeService = EquipeService();

  @override
  void initState() {
    super.initState();
    _equipeFuture = _equipeService.loadEquipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Équipe'),
      ),
      body: FutureBuilder<List<Carte>>(
        future: _equipeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune donnée disponible'));
          } else {
            final equipeList = snapshot.data!;
            return ListView.builder(
              itemCount: equipeList.length,
              itemBuilder: (context, index) {
                final Carte = equipeList[index];
                return ListTile(
                  leading: Image.asset(Carte.image),
                  title: Text(Carte.nom),
                  subtitle: Text(Carte.description),
                );
              },
            );
          }
        },
      ),
    );
  }
}

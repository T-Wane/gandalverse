import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/carte.dart';
import 'package:gandalverse/core/services/partenaire_service.dart';

import '../components/carteCard.dart';

class PartenaireSection extends StatefulWidget {
  @override
  _PartenaireSectionState createState() => _PartenaireSectionState();
}

class _PartenaireSectionState extends State<PartenaireSection> {
  late Future<List<Carte>> _partenaireFuture;
  final PartenaireService _partenaireService = PartenaireService();
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _partenaireFuture = _partenaireService.loadPartenaires();
  }

  @override
  void didUpdateWidget(covariant PartenaireSection oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _partenaireFuture = _partenaireService.loadPartenaires();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _partenaireFuture = _partenaireService.loadPartenaires();
  }

  @override
  Widget build(BuildContext context) {
    _partenaireFuture = _partenaireService.loadPartenaires();
    return StreamBuilder<List<Carte>>(
      stream: _partenaireService.partenaireStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Aucune donnée disponible'));
        } else {
          final partenaireList = snapshot.data!;

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
                itemCount: partenaireList.length,
                itemBuilder: (BuildContext ctx, index) {
                  Carte carte = partenaireList[index];
                  return CarteCard(
                      carte: carte, qgService: _partenaireService);
                }),
          );
        }
      },
    );
  }
}

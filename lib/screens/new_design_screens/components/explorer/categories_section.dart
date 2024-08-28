import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/explorer/categorie/categorie.dart';
import 'package:gandalverse/core/services/explorer_service/explorer_service.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/screens/new_design_screens/components/explorer/cateorigie_item.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  ExplorerService _explorerService = getIt<ExplorerService>();

  CategorieType? _typeSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _explorerService.loadCategories();
  }

  Future<List<CategorieModel>> getCategories() async {
    Map<CategorieType, List<CategorieModel>> _data =
        await _explorerService.categoriserParType();

    return _data[_typeSelected ?? CategorieType.top20] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildCategoriesTypeZone, _buildCategoriesZone()],
    );
  }

  Container get _buildCategoriesTypeZone => Container(
        height: 80,
        width: double.infinity,
        margin: EdgeInsets.all(5),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: CategorieType.values.toList().length,
          itemBuilder: (context, index) {
            CategorieType categorieType = CategorieType.values.toList()[index];
            return AspectRatio(
              aspectRatio: 8 / 9,
              child: CategorieTypeItem(
                  type: categorieType,
                  couleur: Themecolors.ColorWhite,
                  onPress: () {}),
            );
          },
        ),
      );

  Widget _buildCategoriesZone() {
    return FutureBuilder<List<CategorieModel>>(
      future: getCategories(),
      builder:
          (BuildContext context, AsyncSnapshot<List<CategorieModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No categories found'));
        } else {
          List<CategorieModel> dataList = snapshot.data!;
          return Container(
            height: 100,
            width: double.infinity,
            margin: const EdgeInsets.all(5),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                CategorieModel categorie = dataList[index];
                return Container(
                    margin: const EdgeInsets.all(2),
                    width: 200,
                    child: Column(
                      children: [
                        CustomImageView(
                          imagePath: categorie.image!,
                          fit: BoxFit.cover,
                          radius: BorderRadius.circular(10),
                        ),
                      ],
                    ));
              },
            ),
          );
        }
      },
    );
  }
}

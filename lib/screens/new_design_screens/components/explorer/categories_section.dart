import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gandalverse/core/modeles/explorer/categorie/categorie.dart';
import 'package:gandalverse/core/services/explorer_service/explorer_service.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/screens/new_design_screens/components/explorer/categorieType_item.dart';
import 'package:gandalverse/screens/new_design_screens/helper/ui_helper.dart';
import 'package:gandalverse/themes/color/themeColors.dart';
import 'package:gandalverse/widgets/customImageView.dart';
import 'package:gandalverse/widgets/popups/categorieDetails_alert.dart';

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
      children: [
        _buildCategoriesTypeZone,
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: realW(10)),
            child: Text(
              (_typeSelected ?? CategorieType.top20).name.toUpperCase(),
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        _buildCategoriesZone()
      ],
    );
  }

  Container get _buildCategoriesTypeZone => Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: CategorieType.values.toList().length,
          itemBuilder: (context, index) {
            CategorieType categorieType = CategorieType.values.toList()[index];
            return CategorieTypeItem(
                isSelected: (_typeSelected ?? CategorieType.top20).name ==
                    categorieType.name,
                type: categorieType,
                couleur: Themecolors.ColorWhite,
                onPress: () {
                  setState(() {
                    _typeSelected = categorieType;
                  });
                });
          },
        ),
      );

  Widget _buildCategoriesZone() {
    return FutureBuilder<List<CategorieModel>>(
        future: getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategorieModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(5),
              child: const Center(
                child: Text(
                  'En cours de négociation 😎',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          } else {
            List<CategorieModel> dataList = snapshot.data!;
            return Container(
              height: 150,
              width: double.infinity,
              margin: const EdgeInsets.all(5),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    CategorieModel categorie = dataList[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (_) => CategorieDetails_PopUp(
                            categorieModel: categorie,
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 200,
                        child: Column(children: [
                          Expanded(
                            child: Card(
                              elevation: 1.0,
                              shadowColor: Colors.black54,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                // side: BorderSide(
                                //     width: 1.0,
                                //     color: Themecolors.ColorWhite.withOpacity(0.5)),
                              ),
                              child: CustomImageView(
                                imagePath: categorie.image!,
                                fit: BoxFit.cover,
                                width: 200,
                                radius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              categorie.titre ?? '---',
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.ltr,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                color: Themecolors.ColorWhite,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    );
                  }),
            );
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:kabab/models/category.dart';
import 'package:kabab/models/sectionModelItem.dart';
import 'package:kabab/providers/categories.dart';
import 'package:kabab/widgets/section_item.dart';

class CatSectionList extends StatelessWidget {
  final String gettedId;
  final String gettedscetionitle;
  CatSectionList({this.gettedId, this.gettedscetionitle});

  @override
  Widget build(BuildContext context) {
    Category category =
        Categories().items.firstWhere((element) => element.id == gettedId);

    List<SectionModelItem> a = [];
    category.map.forEach((key, value) {
      print(value);
      if (key == gettedscetionitle) {
        a = value;
      }
    });
    return GridView(
      padding: EdgeInsets.all(20),
      children: a
          .map(
            (category) => SectionItem(
              id: category.id,
              title: category.title,
              image: category.image,
              market: category.market,
              price: category.price,
              cansprices: category.cansPrices,
            ),
          )
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        childAspectRatio: 1 / 1.4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}

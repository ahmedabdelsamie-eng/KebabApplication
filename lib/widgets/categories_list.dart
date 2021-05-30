import 'package:flutter/material.dart';
import 'package:kabab/providers/categories.dart';
import 'package:kabab/widgets/category_item.dart';

class CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(20),
      children: Categories()
          .items
          .map(
            (category) => CategoryItem(
              id: category.id,
              title: category.title,
              image: category.image,
            ),
          )
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        childAspectRatio: 3 / 1.8,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}

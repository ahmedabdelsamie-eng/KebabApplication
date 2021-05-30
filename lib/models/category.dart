import 'package:flutter/cupertino.dart';
import 'package:kabab/models/sectionModelItem.dart';

class Category {
  final String id;
  final String title;
  final String image;
  final Map<String, List<SectionModelItem>> map;

  Category(
      {@required this.id,
      @required this.title,
      @required this.image,
      this.map});
}

import 'package:flutter/material.dart';
import 'package:kabab/screens/single_category_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  CategoryItem({@required this.id, @required this.title, @required this.image});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(SingleCategoryScreen.routeName, arguments: {
            'id': id,
            'title': title,
            'image': image,
          });
        },
        child: GridTile(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)
                    // topLeft: Radius.circular(15),
                    // topRight: Radius.circular(15),
                    ),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 30,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.black45),
                  width: 150,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

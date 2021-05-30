import 'package:flutter/material.dart';
import 'package:kabab/screens/section_item_details_screen.dart';

class SectionItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  final String market;
  final String price;
  final Map<String, String> cansprices;
  SectionItem(
      {@required this.id,
      @required this.title,
      @required this.image,
      @required this.market,
      @required this.price,
      @required this.cansprices});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(SectionItemDetailsScreen.routeName, arguments: {
              'id': id,
              'title': title,
              'image': image,
              'market': market,
              'price': price,
              'cansprices': cansprices
            });
          },
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              height: 150,
              child: GridTile(
                child: Stack(
                  children: [
                    Container(
                      child: Center(
                          child: Hero(
                        tag: id,
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                        ),
                      )),
                    ),
                    Positioned(
                      left: 2,
                      top: 2,
                      child: Row(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 30,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.black26,
                        width: 100,
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
          ),
        ),
        FlatButton.icon(
          onPressed: () {},
          label: Text('Add To Cart'),
          icon: Icon(Icons.shopping_cart),
          color: Colors.amber,
        ),
      ],
    );
  }
}

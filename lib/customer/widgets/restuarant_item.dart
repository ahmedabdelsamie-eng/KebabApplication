import 'package:flutter/material.dart';
import 'package:kabab/customer/models/place.dart';
import 'package:kabab/customer/screens/map_screen.dart';
import 'package:kabab/customer/screens/single_restuarant_screen.dart';

class RestuarantItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  final PlaceLocation catLocation;
  RestuarantItem(
      {@required this.id,
      @required this.title,
      @required this.image,
      @required this.catLocation});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              SingleCategoryScreen.routeName,
              arguments: {
                'id': id,
                'title': title,
              },
            );
          },
          child: GridTile(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
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
                ),
                Positioned(
                  left: 5,
                  bottom: 10,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (ctx) => MapScreen(
                            initialLocation: catLocation,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.orange[200],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kabab/customer/models/place.dart';
import 'package:kabab/customer/models/restuarantModel.dart';

import 'restuarant_item.dart';

class RestuarantsList extends StatelessWidget {
  final List<RestuarantModel> gettedList;
  RestuarantsList({this.gettedList});
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: gettedList.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 700),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: RestuarantItem(
                    id: gettedList[index].key,
                    title: gettedList[index].restuarantViewModel.restuarantName,
                    image:
                        gettedList[index].restuarantViewModel.restuarantImage,
                    catLocation: PlaceLocation(
                      longitude:
                          gettedList[index].restuarantViewModel.longitude,
                      latitude: gettedList[index].restuarantViewModel.latitude,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

// print(gettedList.length);
//     return GridView(
//       padding: EdgeInsets.all(20),
//       children: gettedList
//           .map(
//             (restuarant) => RestuarantItem(
//               id: restuarant.key,
//               title: restuarant.restuarantViewModel.restuarantName,
//               image: restuarant.restuarantViewModel.restuarantImage,
//               catLocation: PlaceLocation(
//                 longitude: restuarant.restuarantViewModel.longitude,
//                 latitude: restuarant.restuarantViewModel.latitude,
//               ),
//             ),
//           )
//           .toList(),
//       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 400,
//         childAspectRatio: 3 / 1.8,
//         crossAxisSpacing: 20,
//         mainAxisSpacing: 20,
//       ),
//     );
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselDemo extends StatefulWidget {
  static const routeName = 'cuesol';

  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  CarouselController buttonCarouselController = CarouselController();

  List<String> _images = [
    'assets/images/cr1.jpg',
    'assets/images/cr2.jpg',
    'assets/images/cr3.jpg',
    'assets/images/cr4.jpg',
  ];

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: _images.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width - 15,
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Image.asset(
                    '$i',
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            onPageChanged: (index, _) {
              setState(() {
                _currentIndex = index;
              });
            },
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 500),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 16 / 5,
            enableInfiniteScroll: true,
            reverse: false,
            initialPage: 2,
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _images
                .asMap()
                .map(
                  (index, value) => MapEntry(
                    index,
                    Container(
                      width: 13.0,
                      height: 13.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
                      decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: _currentIndex == index
                              ? Colors.amber
                              : Colors.black),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        )
      ],
    );
  }
}

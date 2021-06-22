import 'package:flutter/material.dart';

class ClipScreen extends StatefulWidget {
  @override
  _ClipScreenState createState() => _ClipScreenState();
}

class _ClipScreenState extends State<ClipScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: ClipPath(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          // padding: EdgeInsets.only(bottom: 10),
          child: Image.asset(
            'assets/images/l.jpg',
            width: double.infinity,
            height: 190,
            fit: BoxFit.fill,
          ),

          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        clipper: CustomClipPath(),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 40;
    while (curXPos < size.width) {
      curXPos += increment;
      curYPos = curYPos == size.height ? size.height - 30 : size.height;
      path.lineTo(curXPos, curYPos);
    }
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

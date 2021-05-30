import 'package:flutter/material.dart';

class BuyCalc extends StatefulWidget {
  final Function bringDAta;
  BuyCalc(this.bringDAta);
  @override
  _BuyCalcState createState() => _BuyCalcState();
}

class _BuyCalcState extends State<BuyCalc> {
  var count1 = 0;
  var count2 = 0;
  var count3 = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white.withOpacity(0.0)),
          //  color: Colors.teal,
          padding: EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    count2 = 0;
                    count3 = 0;
                    count1++;
                    widget.bringDAta(count1, count2, count3);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.teal),
                  child: Icon(
                    Icons.arrow_drop_up_outlined,
                    color: Colors.amber,
                  ),
                ),
              ),
              Text(
                '$count1',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (count1 == 0) {
                      return;
                    }

                    count1--;
                    widget.bringDAta(count1, count2, count3);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.teal),
                  child: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white.withOpacity(0.0)),
          //  color: Colors.teal,
          padding: EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    count1 = 0;
                    count3 = 0;
                    count2++;
                    widget.bringDAta(count1, count2, count3);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.teal),
                  child: Icon(
                    Icons.arrow_drop_up_outlined,
                    color: Colors.amber,
                  ),
                ),
              ),
              Text(
                '$count2',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (count2 == 0) {
                      return;
                    }
                    count2--;
                    widget.bringDAta(count1, count2, count3);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.teal),
                  child: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white.withOpacity(0.0)),
          //  color: Colors.teal,
          padding: EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    count2 = 0;
                    count1 = 0;
                    count3++;
                    widget.bringDAta(count1, count2, count3);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.teal),
                  child: Icon(
                    Icons.arrow_drop_up_outlined,
                    color: Colors.amber,
                  ),
                ),
              ),
              Text(
                '$count3',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (count3 == 0) {
                      return;
                    }
                    count3--;
                    widget.bringDAta(count1, count2, count3);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.teal),
                  child: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    /////////
  }
}

import 'package:flutter/material.dart';

class CalcPart extends StatefulWidget {
  int qu;
  CalcPart(this.qu);
  @override
  _CalcPartState createState() => _CalcPartState();
}

class _CalcPartState extends State<CalcPart> {
  var count1 = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.teal),
      //  color: Colors.teal,
      padding: EdgeInsets.all(3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                widget.qu++;
                // widget.bringDAta(count1, count2, count3);
              });
            },
            child: Container(
              color: count1 == 0 ? Colors.white : Colors.amber,
              child: Icon(
                Icons.arrow_drop_up_outlined,
              ),
            ),
          ),
          Text(
            '${widget.qu}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (widget.qu == 0) {
                  return;
                }

                widget.qu--;
                //widget.bringDAta(count1, count2, count3);
              });
            },
            child: Container(
              // alignment: Alignment.topRight,
              color: Colors.white,
              child: Icon(
                Icons.arrow_drop_down_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

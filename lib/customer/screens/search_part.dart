import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabab/customer/models/restuarantModel.dart';
import 'package:kabab/customer/providers/restuarants_resources.dart';
import 'package:provider/provider.dart';

class SearchPart extends StatefulWidget {
  final Function sentHeight;
  SearchPart({this.sentHeight});
  static const routeName = 'mm';
  @override
  _SearchPart createState() => _SearchPart();
}

class _SearchPart extends State<SearchPart> {
  List<ProductDatum> prods;
  String query = '';
  var forHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);

    prods = [];
  }

  void _onFocusChange() {
    debugPrint("Focus: " + _focus.hasFocus.toString());
    if (_focus.hasFocus) {
      widget.sentHeight(150.0);
    }
    // if (!_focus.hasFocus) {
    //   widget.sentHeight(85.0);
    // }
  }

  final controller = TextEditingController();
  FocusNode _focus = new FocusNode();

  final styleActive = TextStyle(color: Colors.black);
  final styleHint = TextStyle(color: Colors.black54);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 42,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              border: Border.all(color: Colors.amber),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
                focusNode: _focus,
                controller: controller,
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: styleActive.color),
                  suffixIcon: controller.text.isNotEmpty
                      ? GestureDetector(
                          child: Icon(Icons.close, color: Colors.pink),
                          onTap: () {
                            controller.clear();
                            this.query = '';
                            this.prods = [];
                            widget.sentHeight(85.0);

                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        )
                      : null,
                  hintText: 'Search Something..',
                  hintStyle: TextStyle(color: Colors.red),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.red),
                onChanged: (String searchquery) {
                  final prods = Provider.of<Restuarants>(context, listen: false)
                      .restuarants[0]
                      .restuarantViewModel
                      .deptData[0]
                      .productData
                      .where((product) {
                    final titleLower = product.name.toLowerCase();

                    final searchLower = searchquery.toLowerCase();

                    return titleLower.contains(searchLower);
                  }).toList();

                  setState(() {
                    // this.query = searchquery;
                    this.prods = prods;
                    if (this.prods.length > 0) {
                      forHeight = 150.0;
                      // widget.sentHeight(forHeight);
                    }
                  });
                }),
          ),
          Container(
            height: forHeight,
            child: controller.text.isEmpty
                ? null
                : ListView.builder(
                    itemCount: prods.length,
                    itemBuilder: (context, index) {
                      final item = prods[index];

                      return buildProduct(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildProduct(ProductDatum item) => InkWell(
        onTap: () {
          // Navigator.of(context)
          //     .pushNamed(DepartmentProductDetailsScreen.routeName, arguments: {
          //   'prodId': item.productId,
          //   'prodName': item.name,
          //   'prodImage': item.image,
          //   'prodRestuarant': item.restuarantName,
          //   'prodPrice': item.price,
          //   'prodCansprices': item.cansPrices
          // });
        },
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
              item.image,
            ),
          ),
          title: Text(item.name,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(
            item.restuarantName,
            style: TextStyle(color: Colors.amber),
          ),
        ),
      );

  // void searchItem(String searchquery) {
  // final prods = Provider.of<Restuarants>(context, listen: false)
  //     .restuarants[0]
  //     .restuarantViewModel
  //     .deptData[0]
  //     .productData
  //     .where((product) {
  //   final titleLower = product.name.toLowerCase();

  //   final searchLower = searchquery.toLowerCase();

//       return titleLower.contains(searchLower);
//     }).toList();

//     setState(() {
//       this.query = searchquery;
//       this.prods = prods;
//       if (this.prods.length > 0) {
//         forHeight = 150.0;
//         widget.sentHeight(forHeight);
//       }
//     });
//   }
// }

// class SearchWidget extends StatefulWidget {
//   final String text;
//   final ValueChanged<String> onChanged;
//   final String hintText;

//   const SearchWidget({
//     @required this.text,
//     @required this.onChanged,
//     @required this.hintText,
//   });

//   @override
//   _SearchWidgetState createState() => _SearchWidgetState();
// }

// class _SearchWidgetState extends State<SearchWidget> {
//   final controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final styleActive = TextStyle(color: Colors.black);
//     final styleHint = TextStyle(color: Colors.black54);
//     final style =
//         widget.text.isEmpty || widget.text == '0' ? styleHint : styleActive;

//     return Container(
//       height: 42,
//       margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.white,
//         border: Border.all(color: Colors.black26),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           icon: Icon(Icons.search, color: style.color),
//           suffixIcon: widget.text.isNotEmpty
//               ? GestureDetector(
//                   child: Icon(Icons.close, color: style.color),
//                   onTap: () {
//                     controller.clear();
//                     widget.onChanged('0');

//                     FocusScope.of(context).requestFocus(FocusNode());
//                     // Navigator.of(context).pop();
//                   },
//                 )
//               : null,
//           hintText: widget.hintText,
//           hintStyle: style,
//           border: InputBorder.none,
//         ),
//         style: style,
//         onChanged: (value) {
//           widget.onChanged(value);
//         },
//       ),
//     );
//   }
// }
}

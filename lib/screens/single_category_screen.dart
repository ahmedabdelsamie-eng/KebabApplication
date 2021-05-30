import 'package:flutter/material.dart';
import 'package:kabab/widgets/sn_ca_sc_section_list.dart';

class SingleCategoryScreen extends StatefulWidget {
  static const routeName = '/singlecat';
  @override
  _SingleCategoryScreenState createState() => _SingleCategoryScreenState();
}

class _SingleCategoryScreenState extends State<SingleCategoryScreen> {
  var init = true;
  String id;
  String title;
  String image;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (init) {
      final args =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      id = args['id'];
      title = args['title'];
      image = args['image'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Text(
              title,
              style: TextStyle(color: Colors.teal),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
              indicatorWeight: 5,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              isScrollable: true,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  icon: Icon(Icons.local_drink),
                  text: 'المقبلات',
                ),
                Tab(
                  icon: Icon(Icons.local_pizza),
                  text: 'الاطباق الرئيسية',
                ),
                Tab(
                  icon: Icon(Icons.set_meal),
                  text: 'جديدنا',
                ),
                Tab(
                  icon: Icon(Icons.free_breakfast_outlined),
                  text: 'الوجبات',
                ),
                Tab(
                  icon: Icon(Icons.local_pizza),
                  text: 'السندوتشات',
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            CatSectionList(
              gettedId: id,
              gettedscetionitle: 'mokablat',
            ),
            CatSectionList(
              gettedId: id,
              gettedscetionitle: 'maindishs',
            ),
            CatSectionList(
              gettedId: id,
              gettedscetionitle: 'meals',
            ),
            CatSectionList(
              gettedId: id,
              gettedscetionitle: 'New',
            ),
            CatSectionList(
              gettedId: id,
              gettedscetionitle: 'sandwishes',
            ),
          ],
        ),
      ),
    );
  }
}

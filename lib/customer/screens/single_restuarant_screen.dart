import 'package:flutter/material.dart';
import 'package:kabab/customer/widgets/departmentProductsList.dart';

class SingleCategoryScreen extends StatefulWidget {
  static const routeName = '/singleRestuarant';
  @override
  _SingleCategoryScreenState createState() => _SingleCategoryScreenState();
}

class _SingleCategoryScreenState extends State<SingleCategoryScreen> {
  var init = true;
  String id;
  String title;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (init) {
      final args =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      id = args['id'];
      title = args['title'];
    }
    init = false;
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
                  icon: Icon(Icons.set_meal),
                  text: 'الأطباق الرئيسية',
                ),
                Tab(
                  icon: Icon(Icons.local_drink),
                  text: 'المشروبات',
                ),
                Tab(
                  icon: Icon(Icons.set_meal),
                  text: 'المقبلات',
                ),
                Tab(
                  icon: Icon(Icons.wallet_giftcard),
                  text: 'العروض',
                ),
                Tab(
                  icon: Icon(Icons.local_pizza),
                  text: 'السندوتشات',
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            DepartmentProductsList(
              gettedId: id,
              gettedSectionTitle: 'Meals',
            ),
            DepartmentProductsList(
              gettedId: id,
              gettedSectionTitle: 'Drinks',
            ),
            DepartmentProductsList(
              gettedId: id,
              gettedSectionTitle: 'Adds',
            ),
            DepartmentProductsList(
              gettedId: id,
              gettedSectionTitle: 'Offers',
            ),
            DepartmentProductsList(
              gettedId: id,
              gettedSectionTitle: 'Sandwiches',
            ),
          ],
        ),
      ),
    );
  }
}

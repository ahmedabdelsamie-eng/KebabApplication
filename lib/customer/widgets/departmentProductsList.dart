import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kabab/customer/models/restuarantModel.dart';
import 'package:kabab/customer/providers/restuarants_resources.dart';
import 'package:kabab/customer/widgets/departmentProduct.dart';
import 'package:provider/provider.dart';

class DepartmentProductsList extends StatefulWidget {
  final String gettedId;
  final String gettedSectionTitle;

  DepartmentProductsList({this.gettedId, this.gettedSectionTitle});

  @override
  _DepartmentProductsList createState() => _DepartmentProductsList();
}

class _DepartmentProductsList extends State<DepartmentProductsList> {
  var init = true;
  RestuarantModel it;
  RestuarantDepartent restuarantDepartent;
  @override
  void didChangeDependencies() {
    if (init) {
      it = Provider.of<Restuarants>(context, listen: false)
          .restuarants
          .firstWhere((resModel) => resModel.key == widget.gettedId);
      restuarantDepartent = it.restuarantViewModel.deptData.firstWhere(
          (resDept) => resDept.restuarantDeptName == widget.gettedSectionTitle);
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int columnCount = 2;

    return AnimationLimiter(
      child: GridView.count(
        crossAxisSpacing: 5,
        mainAxisSpacing: 12,
        childAspectRatio: 1 / 1.2,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.all(5),
        crossAxisCount: columnCount,
        children: List.generate(
          restuarantDepartent.productData.length,
          (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: Duration(milliseconds: 500),
              columnCount: columnCount,
              child: ScaleAnimation(
                duration: Duration(milliseconds: 900),
                curve: Curves.fastLinearToSlowEaseIn,
                //scale: 1.5,
                child: FadeInAnimation(
                  child: DepartmentProduct(
                    productId: restuarantDepartent.productData[index].productId,
                    name: restuarantDepartent.productData[index].name,
                    image: restuarantDepartent.productData[index].image,
                    price: restuarantDepartent.productData[index].price,
                    dept: restuarantDepartent.restuarantDeptName,
                    restuarantName:
                        restuarantDepartent.productData[index].restuarantName,
                    cansPrices:
                        restuarantDepartent.productData[index].cansPrices,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

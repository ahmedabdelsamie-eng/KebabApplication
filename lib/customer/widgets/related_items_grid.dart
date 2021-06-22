import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kabab/customer/models/restuarantModel.dart';
import 'package:kabab/customer/providers/restuarants_resources.dart';
import 'package:provider/provider.dart';

import 'departmentProduct.dart';

class RelatedGrid extends StatelessWidget {
  final String deptName;
  final String restuarant;

  RelatedGrid(
    this.deptName,
    this.restuarant,
  );
  @override
  Widget build(BuildContext context) {
    RestuarantModel it;
    RestuarantDepartent restuarantDepartent;
    it = Provider.of<Restuarants>(context, listen: false)
        .restuarants
        .firstWhere((resModel) =>
            resModel.restuarantViewModel.restuarantName == restuarant);

    restuarantDepartent = it.restuarantViewModel.deptData
        .firstWhere((resDept) => resDept.restuarantDeptName == deptName);

    return GridView(
      shrinkWrap: true,
      primary: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      children: restuarantDepartent.productData
          .map((item) => DepartmentProduct(
                productId: item.productId,
                name: item.name,
                image: item.image,
                price: item.price,
                dept: restuarantDepartent.restuarantDeptName,
                restuarantName: item.restuarantName,
                cansPrices: item.cansPrices,
              ))
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1 / 1.4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 20,
      ),
    );
  }
}

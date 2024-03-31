import 'dart:collection';

import 'package:visual_analytics/controller/controller.dart';
import 'package:visual_analytics/controller/customer_controller.dart';
import 'package:visual_analytics/controller/product_controller.dart';
import 'package:visual_analytics/controller/sales_controller.dart';
import 'package:visual_analytics/modals/customer_analysis_modal.dart';
import 'package:visual_analytics/modals/data_modal.dart';

class AnalysisService {
  double getTotalIncome() {
    double income = 0;
    for (DataModal modal in Controller.csvData.dataModals) {
      income += (modal.price * modal.quantity);
    }
    Controller.totalIncome = income;
    return income;
  }

  Future<List<CustomerAnalysisModal>>
      generateMapOfUsersWithTheirIndexs() async {
    List<CustomerAnalysisModal> list = [];
    Map<String, List<int>> map = HashMap();
    int i = 0;
    for (DataModal modal in Controller.csvData.dataModals) {
      if (map.containsKey(modal.user)) {
        List<int> temp = map[modal.user]!;
        if (temp.contains(i)) {
          i++;
          continue;
        }
        temp.add(i);
        temp.sort(
          ((a, b) {
            return Controller.csvData.dataModals[a].orderDate
                .compareTo(Controller.csvData.dataModals[b].orderDate);
          }),
        );

        map[modal.user] = temp;
        i++;
      } else {
        List<int> temp = [];
        temp.add(i);
        map[modal.user] = temp;
        i++;
      }
    }
    CustomerController.mapOfUsersWithTheirIndexs = map;
    // print(map);
    return list;
  }

  List<String> giveSortedKeyListOfMapByValues(Map<String, double> map) {
    List<String> list = map.keys.toList();
    list.sort((a, b) => map[b]!.compareTo(map[a]!));
    return list;
  }

  Future<Map<String, double>> generateMapOfUserAndTotalSpend() async {
    if (CustomerController.mapOfUsersWithTheirIndexs.isEmpty) {
      await generateMapOfUsersWithTheirIndexs();
    }
    Map<String, double> map = HashMap();
    CustomerController.mapOfUsersWithTheirIndexs.forEach((user, indexs) {
      double total = 0;
      for (int i in indexs) {
        total += (Controller.csvData.dataModals[i].price *
            Controller.csvData.dataModals[i].quantity);
      }
      map[user] = double.parse(total.toStringAsFixed(2));
    });

    CustomerController.mapOfUserAndTotalSpend = map;
    return map;
  }

  Future<void> generateMapOfUserAndQuantity() async {
    if (CustomerController.mapOfUserAndQuantityBought.isNotEmpty) {
      return;
    }
    CustomerController.mapOfUsersWithTheirIndexs.forEach((key, value) {
      CustomerController.mapOfUserAndQuantityBought[key] = value.length;
    });
  }

  Future<void> geneRateUserNamesSortedWithDate() async {
    for (DataModal modal in Controller.csvData.dataModals) {
      List<DateTime>? list =
          CustomerController.mapOfUserNamesSortedWithDate[modal.user] ?? [];
      list.add(modal.orderDate);
      list.sort((a, b) => a.compareTo(b));
      CustomerController.mapOfUserNamesSortedWithDate[modal.user] = list;
    }
  }

  Future<void> generateMapOfProductWithIndex() async {
    int i = 0;
    for (var modal in Controller.csvData.dataModals) {
      if (ProductController.mapOfProductWithIndexs
          .containsKey(modal.productName)) {
        List<int> list =
            ProductController.mapOfProductWithIndexs[modal.productName]!;
        if (list.contains(i)) {
          i++;
          continue;
        }
        list.add(i);
        list.sort((a, b) {
          return Controller.csvData.dataModals[a].orderDate
              .compareTo(Controller.csvData.dataModals[b].orderDate);
        });
        ProductController.mapOfProductWithIndexs[modal.productName] = list;
      } else {
        List<int> temp = [];
        temp.add(i);
        ProductController.mapOfProductWithIndexs[modal.productName] = temp;
      }
      i++;
    }
    // print(ProductController.mapOfProductWithIndexs);
  }

  Future<void> generateMapOfProductWithTotalPrice() async {
    if (ProductController.mapOfProductWithIndexs.isEmpty) {
      generateMapOfProductWithIndex();
    }
    ProductController.mapOfProductWithIndexs.forEach((key, value) {
      List<int> indexes = value;
      double sum = 0;
      for (int index in indexes) {
        sum += Controller.csvData.dataModals[index].price;
      }
      ProductController.mapOfProductWithTotalPrice[key] = sum;
    });
  }

  Future<void> generateMapOfTotalSalesWithDate() async {
    for (DataModal modal in Controller.csvData.dataModals) {
      if (SalesController.mapOfTotalSalesWithDate
          .containsKey(modal.orderDate)) {
        double sale =
            SalesController.mapOfTotalSalesWithDate[modal.orderDate]! +
                modal.price;
        SalesController.mapOfTotalSalesWithDate[modal.orderDate] = sale;
      } else {
        SalesController.mapOfTotalSalesWithDate[modal.orderDate] = modal.price;
      }
    }
  }
}

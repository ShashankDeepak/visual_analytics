import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visual_analytics/controller/controller.dart';
import 'package:visual_analytics/controller/product_controller.dart';

class ProductData extends StatelessWidget {
  final String productName;
  ProductData({super.key, required this.productName});
  List<TableRow> tableRows = [];
  List<FlSpot> allSpots = [];

  void getChartSpot() {
    List<int> productIndexs =
        ProductController.mapOfProductWithIndexs[productName]!;

    print(productIndexs);

    int i = 0;

    for (var value in productIndexs) {
      print(Controller.csvData.dataModals[value]);
      allSpots.add(FlSpot(
        i.toDouble(),
        double.parse((Controller.csvData.dataModals[value].price *
                Controller.csvData.dataModals[value].quantity)
            .toStringAsFixed(3)),
      ));
      i++;
    }
  }

  Future<void> generateTableRows() async {
    List<int> productIndexes =
        ProductController.mapOfProductWithIndexs[productName]!;
    tableRows.add(
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Text(
                  "${Controller.csvData.headers[Controller.dataIndex.orderIDIndex]}"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Text(
                  "${Controller.csvData.headers[Controller.dataIndex.orderDateIndex]}"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Text(
                  "${Controller.csvData.headers[Controller.dataIndex.userIndex]}"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Text(
                  "${Controller.csvData.headers[Controller.dataIndex.priceIndex]}"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Text(
                  "${Controller.csvData.headers[Controller.dataIndex.quantityIndex]}"),
            ),
          ),
        ],
      ),
    );
    for (var e in productIndexes) {
      tableRows.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(Controller.csvData.dataModals[e].orderID),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(Controller.dateFormat!
                    .format(Controller.csvData.dataModals[e].orderDate)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  Controller.csvData.dataModals[e].user,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(Controller.csvData.dataModals[e].price.toString()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(
                  Controller.csvData.dataModals[e].quantity.toString(),
                ),
              ),
            ),
          ],
        ),
      );
    }
    getChartSpot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: generateTableRows(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              "Total ${Controller.csvData.headers[Controller.dataIndex.priceIndex]} :",
                              style: const TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " ${ProductController.mapOfProductWithTotalPrice[productName]!.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: LineChart(
                          LineChartData(
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  getTitlesWidget: (value, meta) {
                                    DateFormat format = Controller.dateFormat!;
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        " ${format.format(
                                          Controller
                                              .csvData
                                              .dataModals[ProductController
                                                      .mapOfProductWithIndexs[
                                                  productName]![value.toInt()]]
                                              .orderDate,
                                        )}",
                                      ),
                                    );
                                  },
                                  reservedSize: 28,
                                  interval: 1,
                                  showTitles: true,
                                ),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: allSpots,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          border: TableBorder.all(
                            color: Colors.grey,
                          ),
                          children: tableRows,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

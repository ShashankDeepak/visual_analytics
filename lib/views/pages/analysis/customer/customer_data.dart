import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visual_analytics/controller/controller.dart';
import 'package:visual_analytics/controller/customer_controller.dart';
import 'package:visual_analytics/service/analysis_service.dart';

class CustomerData extends StatelessWidget {
  CustomerData({super.key, required this.userName});
  final String userName;
  List<TableRow> tableRows = [];
  List<FlSpot> allSpots = [];

  void getChartSpot() {
    List<int> userIndexs =
        CustomerController.mapOfUsersWithTheirIndexs[userName]!;

    int i = 0;

    for (var value in userIndexs) {
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
    List<int> userIndexes =
        CustomerController.mapOfUsersWithTheirIndexs[userName]!;
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
                  "${Controller.csvData.headers[Controller.dataIndex.productNameIndex]}"),
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
    for (var e in userIndexes) {
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
                  Controller.csvData.dataModals[e].productName,
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
    await AnalysisService().geneRateUserNamesSortedWithDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: generateTableRows(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
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
                          " ${CustomerController.mapOfUserAndTotalSpend[userName]}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Total items bought: ${CustomerController.mapOfUsersWithTheirIndexs[userName]!.length}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 300,
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
                                    format.format(
                                      Controller
                                          .csvData
                                          .dataModals[CustomerController
                                                  .mapOfUsersWithTheirIndexs[
                                              userName]![value.toInt()]]
                                          .orderDate,
                                    ),
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
            );
          },
        ),
      ),
    );
  }
}

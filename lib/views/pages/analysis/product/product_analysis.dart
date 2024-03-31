import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:visual_analytics/controller/controller.dart';
import 'package:visual_analytics/controller/product_controller.dart';
import 'package:visual_analytics/service/analysis_service.dart';
import 'package:visual_analytics/views/pages/analysis/product/product_data.dart';

class ProductAnalysis extends StatefulWidget {
  const ProductAnalysis({super.key});

  @override
  State<ProductAnalysis> createState() => _ProductAnalysisState();
}

class _ProductAnalysisState extends State<ProductAnalysis> {
  AnalysisService as = AnalysisService();
  int totalCBarGraphDataCount = 0;
  List<String> sortedProductNameList = [];
  late Future<void> genData;
  Future<void> generateData() async {
    as.generateMapOfProductWithIndex();
    as.generateMapOfProductWithTotalPrice();
    // print(ProductController.mapOfProductWithTotalPrice);
    sortedProductNameList = as.giveSortedKeyListOfMapByValues(
        ProductController.mapOfProductWithTotalPrice);
    print("---------------------------");
    // print(sortedProductNameList.length);
  }

  List<BarChartGroupData> generateBarCharGroupData() {
    List<BarChartGroupData> list = [];
    for (var key in sortedProductNameList) {
      if (totalCBarGraphDataCount <= 50) {
        print(key);
        list.add(
          BarChartGroupData(
            x: ProductController.mapOfProductWithTotalPrice[key]!.round(),
            barRods: [
              BarChartRodData(
                toY: ProductController.mapOfProductWithTotalPrice[key]!
                    .roundToDouble(),
              ),
            ],
          ),
        );
        totalCBarGraphDataCount++;
      }
    }
    return list;
  }

  @override
  void initState() {
    genData = generateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return FutureBuilder(
        future: genData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Product Analysis"),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Product total ${Controller.csvData.headers[Controller.dataIndex.priceIndex]}",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.09),
                        child: SizedBox(
                          height: size.height * 0.35,
                          width: size.width,
                          child: BarChart(
                            BarChartData(
                              barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) =>
                                          BarTooltipItem(
                                    "${sortedProductNameList.elementAt(groupIndex)} \n ${group.x}",
                                    const TextStyle(),
                                  ),
                                ),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false
                                      // getTitlesWidget: bottomTitles,
                                      ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    getTitlesWidget: (value, meta) =>
                                        const SideTitleWidget(
                                      axisSide: AxisSide.bottom,
                                      child: Text(""),
                                    ),
                                    showTitles: true,
                                  ),
                                ),
                              ),
                              barGroups: generateBarCharGroupData(),
                              // barGroups: [
                              //   BarChartGroupData(
                              //     x: 10,
                              //     barRods: [BarChartRodData(toY: 12)],
                              //   )
                              // ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            const Text(
                              "Fig: Product sales chart (top 50)",
                              style: TextStyle(fontSize: 15),
                            ),
                            const Text(
                              "Hold lines to view",
                              style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Products list",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Controller.csvData
                                      .headers[Controller.dataIndex.userIndex],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    Controller.csvData.headers[
                                        Controller.dataIndex.priceIndex],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 300,
                              child: ListView(
                                children: as
                                    .giveSortedKeyListOfMapByValues(
                                        ProductController
                                            .mapOfProductWithTotalPrice)
                                    .map((e) => Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => ProductData(
                                                      productName: e),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(e),
                                                    Text(ProductController
                                                        .mapOfProductWithTotalPrice[
                                                            e]!
                                                        .toStringAsFixed(2))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

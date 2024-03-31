import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:visual_analytics/controller/controller.dart';
import 'package:visual_analytics/controller/sales_controller.dart';
import 'package:visual_analytics/service/analysis_service.dart';
import 'package:visual_analytics/views/pages/analysis/customer/customer_analysis.dart';
import 'package:visual_analytics/views/pages/analysis/product/product_analysis.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AnalysisService as = AnalysisService();
  List<FlSpot> allSpots = [];
  List<DateTime> sortedDateTime = [];
  void getChartSpot() {
    sortedDateTime = SalesController.mapOfTotalSalesWithDate.keys.toList();
    sortedDateTime.sort();
    int i = 0;
    if (allSpots.isEmpty) {
      for (var value in sortedDateTime) {
        if (i % 10 == 0) {
          allSpots.add(
            FlSpot(
              i.toDouble(),
              double.parse(
                SalesController.mapOfTotalSalesWithDate[value]!
                    .toStringAsFixed(2),
              ),
            ),
          );
        }
        i++;
      }
    }
    print(allSpots.length);
  }

  Future<void> getData() async {
    await as.generateMapOfTotalSalesWithDate();
    getChartSpot();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.2,
                      width: size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Total Income : ",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              Controller.totalIncome.toStringAsFixed(2),
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 23,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Sales Chart timeline",
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: LineChart(
                        LineChartData(
                          lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (touchedSpots) {
                              List<LineTooltipItem> lineSpot = [];
                              for (var element in touchedSpots) {
                                lineSpot.add(LineTooltipItem(
                                    Controller.dateFormat!.format(
                                            sortedDateTime[element.x.round()]) +
                                        "\n" +
                                        element.y.toStringAsFixed(2),
                                    const TextStyle()));
                              }
                              return lineSpot;
                            },
                          )),
                          titlesData: const FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 28,
                                interval: 1,
                                showTitles: false,
                              ),
                            ),
                            topTitles: AxisTitles(
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
                    SizedBox(
                      height: size.height * 0.4,
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 10 / 3,
                          ),
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CustomerAnalysis(),
                                  ),
                                )
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(
                                  child: Text("Customer Analysis"),
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ProductAnalysis(),
                                  ),
                                )
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(
                                  child: Text("Product Analysis"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:visual_analytics/controller/controller.dart';
import 'package:visual_analytics/controller/customer_controller.dart';
import 'package:visual_analytics/service/analysis_service.dart';
import 'package:visual_analytics/views/pages/analysis/customer/customer_data.dart';

class CustomerAnalysis extends StatefulWidget {
  const CustomerAnalysis({super.key});

  @override
  State<CustomerAnalysis> createState() => _CustomerAnalysisState();
}

class _CustomerAnalysisState extends State<CustomerAnalysis> {
  int totalCBarGraphDataCount = 0;
  List<String> sortedUserNameList = [];
  ScrollController singleChildScrollController = ScrollController();
  AnalysisService analysisService = AnalysisService();
  late Future<void> genValues;
  Future<void> generateValues() async {
    await analysisService.generateMapOfUserAndTotalSpend();
    sortedUserNameList = analysisService.giveSortedKeyListOfMapByValues(
        CustomerController.mapOfUserAndTotalSpend);
    await analysisService.generateMapOfUserAndQuantity();
  }

  @override
  void initState() {
    genValues = generateValues();
    super.initState();
  }

  String getUserName(double val) {
    String ans = "";
    CustomerController.mapOfUserAndTotalSpend.forEach((key, value) {
      if (val.round() == value.round()) {
        ans = key;
      }
    });
    return ans;
  }

  List<BarChartGroupData> generateBarCharGroupData() {
    List<BarChartGroupData> list = [];
    for (var key in sortedUserNameList) {
      if (totalCBarGraphDataCount <= 50) {
        list.add(
          BarChartGroupData(
            x: CustomerController.mapOfUserAndTotalSpend[key]!.round(),
            barRods: [
              BarChartRodData(
                toY: CustomerController.mapOfUserAndTotalSpend[key]!,
              ),
            ],
          ),
        );
        totalCBarGraphDataCount++;
      }
    }
    return list;
  }

  List<ScatterSpot> generateScatterSpotQunatityVsTotalSpend() {
    return List.generate(
      sortedUserNameList.length,
      (index) => ScatterSpot(
        CustomerController
            .mapOfUsersWithTheirIndexs[sortedUserNameList[index]]!.length
            .toDouble(),
        CustomerController.mapOfUserAndTotalSpend[sortedUserNameList[index]]!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return FutureBuilder<void>(
      future: genValues,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Customer Analysis"),
                centerTitle: true,
              ),
              body: Scrollbar(
                trackVisibility: true,
                thumbVisibility: true,
                controller: singleChildScrollController,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Customer total ${Controller.csvData.headers[Controller.dataIndex.priceIndex]}",
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
                                    "${sortedUserNameList.elementAt(groupIndex)} \n ${group.x}",
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
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            const Text(
                              "Fig: Customer expense chart (top 50)",
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
                                "Customers list",
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
                                children: analysisService
                                    .giveSortedKeyListOfMapByValues(
                                        CustomerController
                                            .mapOfUserAndTotalSpend)
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
                                                  builder: (_) =>
                                                      CustomerData(userName: e),
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
                                                    Text(CustomerController
                                                        .mapOfUserAndTotalSpend[
                                                            e]
                                                        .toString())
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 50),
                        child: Text(
                          "Frequency of ${Controller.csvData.headers[Controller.dataIndex.priceIndex]} vs. Total Value",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20, right: 20, bottom: 50),
                        child: SizedBox(
                          height: 300,
                          child: ScatterChart(
                            ScatterChartData(
                                scatterSpots:
                                    generateScatterSpotQunatityVsTotalSpend(),
                                scatterTouchData: ScatterTouchData(
                                  enabled: false,
                                ),
                                scatterLabelSettings: ScatterLabelSettings()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

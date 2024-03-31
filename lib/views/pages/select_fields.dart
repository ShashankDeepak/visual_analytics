import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visual_analytics/controller/controller.dart';
import 'package:visual_analytics/modals/data_index.dart';
import 'package:visual_analytics/service/analysis_service.dart';
import 'package:visual_analytics/service/csv_service.dart';
import 'package:visual_analytics/views/pages/home_page.dart';

class SelectFields extends StatefulWidget {
  const SelectFields({super.key});

  @override
  State<SelectFields> createState() => _SelectFieldsState();
}

class _SelectFieldsState extends State<SelectFields> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to Visual Analytics",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Step 2 : Choose proper fields",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    tooltip: "Clear fields",
                    onPressed: () {
                      Controller.dataIndex.orderIDIndex = -1;
                      Controller.dataIndex.productNameIndex = -1;
                      Controller.dataIndex.priceIndex = -1;
                      Controller.dataIndex.orderDateIndex = -1;
                      Controller.dataIndex.quantityIndex = -1;
                      Controller.dataIndex.userIndex = -1;
                      Controller.dataIndex.descriptionIndex = -1;
                      Controller.dataIndex.ratingIndex = -1;
                      setState(() {});
                    },
                    icon: const Icon(Icons.history)),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        const Text(
                          "Order ID:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        PopupMenuButton(
                          onSelected: (value) {
                            setState(() {
                              DataIndex indexs = Controller.dataIndex;
                              if (indexs.orderIDIndex == value ||
                                  indexs.productNameIndex == value ||
                                  indexs.priceIndex == value ||
                                  indexs.orderDateIndex == value ||
                                  indexs.quantityIndex == value ||
                                  indexs.userIndex == value ||
                                  indexs.descriptionIndex == value ||
                                  indexs.ratingIndex == value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Field already taken"),
                                ));
                              } else {
                                Controller.dataIndex.orderIDIndex = value;
                              }
                            });
                          },
                          itemBuilder: (BuildContext bc) {
                            return List.generate(
                              Controller.csvData.headers.length,
                              (index) => PopupMenuItem(
                                value: index,
                                child: Text(Controller.csvData.headers[index]),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              height: 30,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Controller.dataIndex.orderIDIndex == -1
                                  ? const SizedBox.shrink()
                                  : Center(
                                      child: Text(
                                        Controller.csvData.headers[
                                            Controller.dataIndex.orderIDIndex],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Text(
                          "   *",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        const Text(
                          "Order Date:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        PopupMenuButton(
                          onSelected: (value) {
                            setState(() {
                              DataIndex indexs = Controller.dataIndex;
                              if (indexs.orderIDIndex == value ||
                                  indexs.productNameIndex == value ||
                                  indexs.priceIndex == value ||
                                  indexs.orderDateIndex == value ||
                                  indexs.quantityIndex == value ||
                                  indexs.userIndex == value ||
                                  indexs.descriptionIndex == value ||
                                  indexs.ratingIndex == value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Field already taken"),
                                ));
                              } else {
                                Controller.dataIndex.orderDateIndex = value;
                              }
                            });
                          },
                          itemBuilder: (BuildContext bc) {
                            return List.generate(
                              Controller.csvData.headers.length,
                              (index) => PopupMenuItem(
                                value: index,
                                child: Text(Controller.csvData.headers[index]),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              height: 30,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Controller.dataIndex.orderDateIndex == -1
                                  ? const SizedBox.shrink()
                                  : Center(
                                      child: Text(
                                        Controller.csvData.headers[Controller
                                            .dataIndex.orderDateIndex],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Text(
                          "   *",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 30,
                          ),
                        ),
                        const Text(
                          "   Date Format:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: PopupMenuButton(
                            onSelected: (value) {
                              setState(() {
                                Controller.dateFormat = DateFormat(value);
                              });
                            },
                            itemBuilder: (BuildContext bc) {
                              return [
                                const PopupMenuItem(
                                  value: "dd-MM-yyyy",
                                  child: Text("dd-MM-yyyy"),
                                ),
                                const PopupMenuItem(
                                  value: "yyyy-MM-dd",
                                  child: Text("yyyy-MM-dd"),
                                ),
                                const PopupMenuItem(
                                  value: "yyyy/MM/dd",
                                  child: Text("yyyy/MM/dd"),
                                ),
                                const PopupMenuItem(
                                  value: "dd/MM/yyyy",
                                  child: Text("dd/MM/yyyy"),
                                ),
                              ];
                            },
                            child: Container(
                              height: 30,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Controller.dateFormat == null
                                  ? const SizedBox.shrink()
                                  : Center(
                                      child:
                                          Text(Controller.dateFormat!.pattern!),
                                    ),
                            ),
                          ),
                        ),
                        const Text(
                          "   *",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        const Text(
                          "Product Name:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        PopupMenuButton(
                          onSelected: (value) {
                            setState(() {
                              DataIndex indexs = Controller.dataIndex;
                              if (indexs.orderIDIndex == value ||
                                  indexs.productNameIndex == value ||
                                  indexs.priceIndex == value ||
                                  indexs.orderDateIndex == value ||
                                  indexs.quantityIndex == value ||
                                  indexs.userIndex == value ||
                                  indexs.descriptionIndex == value ||
                                  indexs.ratingIndex == value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Field already taken"),
                                ));
                              } else {
                                Controller.dataIndex.productNameIndex = value;
                              }
                            });
                          },
                          itemBuilder: (BuildContext bc) {
                            return List.generate(
                              Controller.csvData.headers.length,
                              (index) => PopupMenuItem(
                                value: index,
                                child: Text(Controller.csvData.headers[index]),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              height: 30,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Controller.dataIndex.productNameIndex == -1
                                  ? const SizedBox.shrink()
                                  : Center(
                                      child: Text(
                                        Controller.csvData.headers[Controller
                                            .dataIndex.productNameIndex],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Text(
                          "   *",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        const Text(
                          "Description: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        PopupMenuButton(
                          onSelected: (value) {
                            setState(() {
                              DataIndex indexs = Controller.dataIndex;
                              if (indexs.orderIDIndex == value ||
                                  indexs.productNameIndex == value ||
                                  indexs.priceIndex == value ||
                                  indexs.orderDateIndex == value ||
                                  indexs.quantityIndex == value ||
                                  indexs.userIndex == value ||
                                  indexs.descriptionIndex == value ||
                                  indexs.ratingIndex == value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Field already taken"),
                                ));
                              } else {
                                Controller.dataIndex.descriptionIndex = value;
                              }
                            });
                          },
                          itemBuilder: (BuildContext bc) {
                            return List.generate(
                              Controller.csvData.headers.length,
                              (index) => PopupMenuItem(
                                value: index,
                                child: Text(Controller.csvData.headers[index]),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              height: 30,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Controller.dataIndex.descriptionIndex == -1
                                  ? const SizedBox.shrink()
                                  : Center(
                                      child: Text(
                                        Controller.csvData.headers[Controller
                                            .dataIndex.descriptionIndex!],
                                      ),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        const Text(
                          "Price:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        PopupMenuButton(
                          onSelected: (value) {
                            setState(() {
                              DataIndex indexs = Controller.dataIndex;
                              if (indexs.orderIDIndex == value ||
                                  indexs.productNameIndex == value ||
                                  indexs.priceIndex == value ||
                                  indexs.orderDateIndex == value ||
                                  indexs.quantityIndex == value ||
                                  indexs.userIndex == value ||
                                  indexs.descriptionIndex == value ||
                                  indexs.ratingIndex == value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Field already taken"),
                                ));
                              } else {
                                Controller.dataIndex.priceIndex = value;
                              }
                            });
                          },
                          itemBuilder: (BuildContext bc) {
                            return List.generate(
                              Controller.csvData.headers.length,
                              (index) => PopupMenuItem(
                                value: index,
                                child: Text(Controller.csvData.headers[index]),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              height: 30,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Controller.dataIndex.priceIndex == -1
                                  ? const SizedBox.shrink()
                                  : Center(
                                      child: Text(
                                        Controller.csvData.headers[
                                            Controller.dataIndex.priceIndex],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Text(
                          "   *",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        const Text(
                          "User:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        PopupMenuButton(
                          onSelected: (value) {
                            setState(() {
                              DataIndex indexs = Controller.dataIndex;
                              if (indexs.orderIDIndex == value ||
                                  indexs.productNameIndex == value ||
                                  indexs.priceIndex == value ||
                                  indexs.orderDateIndex == value ||
                                  indexs.quantityIndex == value ||
                                  indexs.userIndex == value ||
                                  indexs.descriptionIndex == value ||
                                  indexs.ratingIndex == value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Field already taken"),
                                ));
                              } else {
                                Controller.dataIndex.userIndex = value;
                              }
                            });
                          },
                          itemBuilder: (BuildContext bc) {
                            return List.generate(
                              Controller.csvData.headers.length,
                              (index) => PopupMenuItem(
                                value: index,
                                child: Text(Controller.csvData.headers[index]),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              height: 30,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Controller.dataIndex.userIndex == -1
                                  ? const SizedBox.shrink()
                                  : Center(
                                      child: Text(
                                        Controller.csvData.headers[
                                            Controller.dataIndex.userIndex],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Text(
                          "   *",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        const Text(
                          "Quantity:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        PopupMenuButton(
                          onSelected: (value) {
                            setState(() {
                              DataIndex indexs = Controller.dataIndex;
                              if (indexs.orderIDIndex == value ||
                                  indexs.productNameIndex == value ||
                                  indexs.priceIndex == value ||
                                  indexs.orderDateIndex == value ||
                                  indexs.quantityIndex == value ||
                                  indexs.userIndex == value ||
                                  indexs.descriptionIndex == value ||
                                  indexs.ratingIndex == value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Field already taken"),
                                ));
                              } else {
                                Controller.dataIndex.quantityIndex = value;
                              }
                            });
                          },
                          itemBuilder: (BuildContext bc) {
                            return List.generate(
                              Controller.csvData.headers.length,
                              (index) => PopupMenuItem(
                                value: index,
                                child: Text(Controller.csvData.headers[index]),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              height: 30,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Controller.dataIndex.quantityIndex == -1
                                  ? const SizedBox.shrink()
                                  : Center(
                                      child: Text(
                                        Controller.csvData.headers[
                                            Controller.dataIndex.quantityIndex],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Text(
                          "   *",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        const Text(
                          "Ratings:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        PopupMenuButton(
                          onSelected: (value) {
                            setState(() {
                              DataIndex indexs = Controller.dataIndex;
                              if (indexs.orderIDIndex == value ||
                                  indexs.productNameIndex == value ||
                                  indexs.priceIndex == value ||
                                  indexs.orderDateIndex == value ||
                                  indexs.quantityIndex == value ||
                                  indexs.userIndex == value ||
                                  indexs.descriptionIndex == value ||
                                  indexs.ratingIndex == value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Field already taken"),
                                ));
                              } else {
                                Controller.dataIndex.ratingIndex = value;
                              }
                            });
                          },
                          itemBuilder: (BuildContext bc) {
                            return List.generate(
                              Controller.csvData.headers.length,
                              (index) => PopupMenuItem(
                                value: index,
                                child: Text(Controller.csvData.headers[index]),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              height: 30,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Controller.dataIndex.ratingIndex == -1
                                  ? const SizedBox.shrink()
                                  : Center(
                                      child: Text(
                                        Controller.csvData.headers[
                                            Controller.dataIndex.ratingIndex!],
                                      ),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                ),
                onPressed: () async {
                  DataIndex indexs = Controller.dataIndex;
                  if (indexs.orderIDIndex != -1 &&
                      indexs.productNameIndex != -1 &&
                      indexs.priceIndex != -1 &&
                      indexs.orderDateIndex != -1 &&
                      indexs.quantityIndex != -1 &&
                      indexs.userIndex != -1 &&
                      Controller.dateFormat != null) {
                    CsvService csvService = CsvService();
                    await csvService
                        .generateDataModels(Controller.csvData.rawData);
                    print(Controller.csvData.dataModals);
                    AnalysisService service = AnalysisService();
                    service.getTotalIncome();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                      (route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Some fields marked with * are empty"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Next",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

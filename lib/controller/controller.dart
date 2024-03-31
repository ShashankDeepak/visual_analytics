import 'dart:io';
import 'package:intl/intl.dart';
import 'package:visual_analytics/modals/csv_data.dart';
import 'package:visual_analytics/modals/data_index.dart';

class Controller {
  static DataIndex dataIndex = DataIndex(
    orderIDIndex: -1,
    productNameIndex: -1,
    orderDateIndex: -1,
    priceIndex: -1,
    userIndex: -1,
    quantityIndex: -1,
    descriptionIndex: -1,
    ratingIndex: -1,
  );
  static CsvData csvData = CsvData(file: File(""));
  static double totalIncome = 0;
  static DateFormat? dateFormat;
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:visual_analytics/modals/data_modal.dart';

class CsvData {
  File file;
  List<String> rawData = [];
  List<dynamic> headers = [];
  List<DataModal> dataModals = [];
  CsvData({
    required this.file,
  });
}

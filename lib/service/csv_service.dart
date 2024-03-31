import 'dart:convert';
import 'dart:io';
import 'package:visual_analytics/controller/controller.dart';
import 'package:visual_analytics/modals/data_index.dart';
import 'package:visual_analytics/modals/data_modal.dart';

class CsvService {
  static DataIndex? dataIndex;

  Future<void> setCsvFile(File file) async {
    Controller.csvData.file = file;
    await _generateHeaders();
  }

  Future<void> _generateHeaders() async {
    List<String> lines = [];
    await Controller.csvData.file
        .openRead()
        .map(utf8.decode)
        .transform(const LineSplitter())
        .forEach((l) {
      lines.add(l);
    });
    print(lines);
    Controller.csvData.rawData = lines;
    Controller.csvData.headers = lines[0].split(",");
  }

  Future<void> generateDataModels(List<String> lines) async {
    for (int i = 1; i < lines.length; i++) {
      if (lines[i].contains("\"")) {
        int first = lines[i].indexOf("\"");
        int last = lines[i].lastIndexOf("\"");
        String s = "";
        for (int a = first; a <= last; a++) {
          if (lines[i][a] != ",") {
            s += lines[i][a];
          }
        }
        lines[i] = lines[i].substring(0, first + 1) +
            s +
            lines[i].substring(first + s.length);
      }

      Controller.csvData.dataModals
          .add(DataModal.fromList(lines[i].split(",")));
    }
  }
}

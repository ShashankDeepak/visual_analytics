import 'package:flutter/material.dart';
import 'package:visual_analytics/service/csv_service.dart';
import 'package:visual_analytics/service/file_service.dart';
import 'package:visual_analytics/views/pages/select_fields.dart';

class PickCsv extends StatelessWidget {
  PickCsv({super.key});
  final CsvService csvService = CsvService();
  @override
  Widget build(BuildContext context) {
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
                  "Step 1 : Choose your csv file",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    FileService fileService = FileService();
                    var file = await fileService.pickFile();
                    if (file != null) {
                      await csvService.setCsvFile(file).then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SelectFields(),
                              ),
                            ),
                          );
                    }
                  },
                  child: const Text("Pick CSV"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

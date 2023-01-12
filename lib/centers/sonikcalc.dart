import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as p;

final Uint8List fontData = File('assets/fonts/Hancom Gothic Regular.ttf').readAsBytesSync();
final ttf = pw.Font.ttf(fontData.buffer.asByteData());
pw.Document pdf = pw.Document();

class SonikCalcPage extends StatefulWidget {
  const SonikCalcPage({super.key});

  @override
  State<SonikCalcPage> createState() => _SonikCalcPageState();
}

class _SonikCalcPageState extends State<SonikCalcPage> {
  late DropzoneViewController controller;

  @override
  void initState() {
    // create pdf file
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('한글도 됩니까', style: pw.TextStyle(font: ttf, fontSize: 40)),
          ); // Center
        })); // Page
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              children: [
                DropzoneView(
                  onCreated: (controller) {
                    this.controller = controller;
                  },
                  onDrop: acceptFile,
                ),
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_upload,
                      size: 100,
                    ),
                    const Text('Drop Files here'),
                    const SizedBox(height: 5),
                    const Text('or'),
                    const SizedBox(height: 5),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final events = await controller.pickFiles();
                        if (events.isEmpty) return;
                        acceptFile(events.first);
                      },
                      icon: const Icon(Icons.search),
                      label: const Text('Choose File'),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Stack(
            children: [
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.cloud_upload,
                    size: 100,
                  )
                ],
              ))
            ],
          ),
        ),
      ],
    );
  }

  Future acceptFile(dynamic event) async {
    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);
    final file = await controller.getFileData(event);

    //* validate if mime type is excel
    if (mime == 'application/docxconverter' ||
        mime == 'application/haansoftxlsx' ||
        mime == 'application/kset' ||
        mime == 'application/vnd.ms-excel.12' ||
        mime == 'application/vnd.openxmlformats-officedocument.spreadsheetml.shee' ||
        mime == 'x-softmaker-pm') {
      final reader = Excel.decodeBytes(file.buffer.asUint8List());

      // print reader table
      for (var table in reader.tables.keys) {
        print(table); //sheet Name
        print(reader.tables[table]!.maxCols);
        print(reader.tables[table]!.maxRows);
        for (var row in reader.tables[table]!.rows) {
          print('$row');
        }
      }
    } else return;
    print('name: $name, mime: $mime, bytes: $bytes, url: $url');
  }
}

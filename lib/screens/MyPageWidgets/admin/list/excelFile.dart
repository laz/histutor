import 'dart:io';

import 'package:histutor/model/Tutee.dart';
import 'package:histutor/model/Tutor.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

class makeExcelFile{

  Future<void> createExcelTutee(List<Tutee> tuteeList) async
  {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    final List<Object> lst = ['학번', '이름', '시간(분)'];
    sheet.importList(lst, 1, 1, false);
    int i = 2;
    for(Tutee t in tuteeList){
      if(t.tuteeTime > 0) {
        final List<Object> lst = [t.id, t.name, t.tuteeTime];
        sheet.importList(lst, i, 1, false);
        i = i + 1;
      }
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if(kIsWeb){
      AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
        ..setAttribute("download", "tutee.xlsx")
        ..click();
    }
    else{
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = '$path/tutee.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }

  Future<void> createExcelTutor(List<Tutor> tutorList) async
  {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    final List<Object> lst = ['학번', '이름', '시간(분)'];
    sheet.importList(lst, 1, 1, false);
    int i = 2;
    for(Tutor t in tutorList){
      if(t.tutorTime > 0) {
        final List<Object> lst = [t.id, t.name, t.tutorTime];
        sheet.importList(lst, i, 1, false);
        i = i + 1;
      }
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if(kIsWeb){
      AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
        ..setAttribute("download", "tutor.xlsx")
        ..click();
    }
    else{
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = '$path/tutor.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }

}

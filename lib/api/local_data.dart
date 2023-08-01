import 'dart:convert';

import 'package:flutter/services.dart';

class LocalData {
  Future<List<dynamic>> fetchData(int pageNumber) async {
    String result = await rootBundle.loadString('assets/hafs_smart_v8.json');

    if (result.isNotEmpty) {
      List<dynamic> ayate = jsonDecode(result);
      List<dynamic> pageAyah =
          ayate.where((element) => element['page'] == pageNumber).toList();
      return pageAyah;
    }
    return Future.error('error ');
  }
}

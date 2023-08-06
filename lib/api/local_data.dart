import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quran_kareem/models/ayah.dart';

class LocalData {
  Future<List<List<Ayah>>> fetchData(int pageNumber) async {
    List<List<Ayah>> pageAyah = [];
    String result = await rootBundle.loadString('assets/hafs_smart_v8.json');
    if (result.isNotEmpty) {
      List<dynamic> ayate = jsonDecode(result);

      for (int i = 1; i <= 604; i++) {
        List<Ayah> temp = [];

        // ignore: avoid_function_literals_in_foreach_calls
        ayate.forEach(
          (element) {
            if (element['page'] == pageNumber) {
              temp.add(Ayah.fromJson(element));
            }
            return pageAyah.add(temp);
          },
        );
      }
      return pageAyah;
    }
    return Future.error('error ');
  }
}

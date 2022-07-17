import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gallery/model/quotes_model.dart';
import 'package:http/http.dart' as http;

class GetQuotes {
  static Future<QuotesModel?> getQuotes() async {
    http.Response response = await http.get(
      Uri.parse(
          "http://karpinfosolution-001-site13.gtempurl.com/API/quotes.php"),
    );
    if (response.statusCode == 200) {
      log("Quotes Response==>${jsonDecode(response.body)}");
      return quotesModelFromJson(response.body);
    } else {
      return null;
    }
  }
}

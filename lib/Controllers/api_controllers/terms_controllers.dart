import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:yuktidea_flutter_assemgment/Controllers/Theme/app_color.dart';

import '../../Model/country_model.dart';

class TermsConditionController extends GetxController {
  var termsAndConditions = <Widget>[].obs;
  var updateDate = ''.obs;
  var title = ''.obs;

  @override
  void onInit() {
    fetchTermsAndConditions();

    super.onInit();
  }

  void fetchTermsAndConditions() async {
    final response = await http.get(Uri.parse('https://studylancer.yuktidea.com/api/terms-conditions'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final content = parsedResponse['data']['content'];
      final document = htmlParser.parse(content);
      final headings = document.querySelectorAll('h1');
      final paragraphs = document.querySelectorAll('p');

      title.value = parsedResponse['data']['title'];
      updateDate.value = parsedResponse['data']['updated_at'];
      List<Widget> formattedContent = [];
      for (var i = 0; i < headings.length; i++) {
        formattedContent.add(SizedBox(height: 20));
        formattedContent.add(
          RichText(
            text: TextSpan(
              text: '${headings[i].text}',
              style: TextStyle(color: CustomTheme.secondaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        );
        formattedContent.add(SizedBox(height: 20));
        formattedContent.add(
          RichText(
            text: TextSpan(
              text: '${paragraphs[i].text}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }

      termsAndConditions.value = formattedContent;
    } else {
      print('Failed to load terms and conditions');
    }
  }
  DateTime parseDate(String dateString) {

    RegExp regex = RegExp(r'^(\d{4})-(\d{2})-(\d{2})');
    RegExpMatch? match = regex.firstMatch(dateString);
    if (match != null) {
      int year = int.parse(match.group(1)!);
      int month = int.parse(match.group(2)!);
      int day = int.parse(match.group(3)!);
      return DateTime(year, month, day);
    } else {

      return DateTime.now();
    }
  }

}


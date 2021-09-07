// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:dust/models/airResult.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;

void main() {
  test('http 통신 테스트', () async {
    var response = await http.get(Uri.parse(
        'http://api.airvisual.com/v2/nearest_city?key=20616a46-ee45-496a-98df-143b5d7da086'));
    expect(response.statusCode, 200);

    AirResult result = AirResult.fromJson(jsonDecode(response.body));
    expect(result.status, 'success');
    print(response.body);
  });
}

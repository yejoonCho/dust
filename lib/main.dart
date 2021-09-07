import 'package:dust/models/airResult.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  late AirResult _result;

  Future<AirResult> fetchData() async {
    var response = await http.get(Uri.parse(
        'http://api.airvisual.com/v2/nearest_city?key=20616a46-ee45-496a-98df-143b5d7da086'));
    AirResult result = AirResult.fromJson(jsonDecode(response.body));
    return result;
  }

  @override
  void initState() {
    super.initState();
    fetchData().then((airResult) {
      _result = airResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('현재 위치 미세먼지', style: TextStyle(fontSize: 30)),
            SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('얼굴사진'),
                        Text("${_result.data!.current!.pollution!.aqius}",
                            style: TextStyle(fontSize: 40)),
                        Text('보통', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    color: Colors.yellow,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text('이미지'),
                          SizedBox(width: 16),
                          Text('11°', style: TextStyle(fontSize: 16))
                        ],
                      ),
                      Text('습도 100%'),
                      Text('풍속 5.7m.s'),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
                child: Icon(Icons.refresh),
                onPressed: () {},
                style: ElevatedButton.styleFrom(primary: Colors.orange))
          ],
        )),
      ),
    );
  }
}

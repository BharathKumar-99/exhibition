import 'dart:convert';

import 'package:exhibition/Model/WeekSales.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Services/Productapi.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<Weeksales> chartData = [];
  Future loaddata() async {
    var jsonResponse;
    await ProductApi.getweeklist().then((value) => {
          jsonResponse = json.decode(value),
          print("0"),
          setState(() {
            for (Map<String, dynamic> i in jsonResponse) {
              chartData.add(Weeksales.fromJson(i));
            }
          })
        });
  }

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: ProductApi.getweeklist(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(text: 'Half yearly sales analysis'),
                    series: <ChartSeries<Weeksales, String>>[
                      LineSeries<Weeksales, String>(
                        dataSource: chartData,
                        xValueMapper: (Weeksales sales, _) => sales.month,
                        yValueMapper: (Weeksales sales, _) => sales.sales,
                      )
                    ]);
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

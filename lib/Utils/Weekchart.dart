import 'dart:convert';

import 'package:exhibition/Model/WeekSales.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Services/Productapi.dart';

class WeekChart extends StatefulWidget {
  const WeekChart({
    Key? key,
  }) : super(key: key);

  @override
  State<WeekChart> createState() => _WeekChartState();
}

class _WeekChartState extends State<WeekChart> {
  List<Weeksales> chartData = [];
  Future loaddata() async {
    var jsonResponse;
    await ProductApi.getweeklist().then((value) => {
          jsonResponse = json.decode(value),
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
      body: FutureBuilder(
        future: ProductApi.getweeklist(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SfCartesianChart(
                margin: const EdgeInsets.only(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: 0,
                ),
                plotAreaBorderWidth: 0,
                plotAreaBackgroundColor: Colors.white,
                primaryXAxis: CategoryAxis(
                    majorGridLines: const MajorGridLines(width: 0)),
                primaryYAxis: CategoryAxis(
                    //to hide whole axis
                    majorGridLines: const MajorGridLines(width: 0)),
                tooltipBehavior: TooltipBehavior(enable: false),
                title: ChartTitle(text: 'Week Sales'),
                series: <ChartSeries<Weeksales, String>>[
                  SplineAreaSeries<Weeksales, String>(
                    markerSettings: const MarkerSettings(isVisible: true),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelAlignment: ChartDataLabelAlignment.top,
                    ),
                    dataSource: chartData,
                    color: Colors.blue,
                    xValueMapper: (Weeksales sales, _) => sales.month,
                    yValueMapper: (Weeksales sales, _) => sales.sales,
                    animationDuration: 2000,
                    animationDelay: 1000,
                  )
                ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

import 'dart:convert';

import 'package:exhibition/Model/MonthSales.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Services/Productapi.dart';

class MonthChart extends StatefulWidget {
  const MonthChart({
    Key? key,
  }) : super(key: key);

  @override
  State<MonthChart> createState() => _MonthChartState();
}

class _MonthChartState extends State<MonthChart> {
  List<MonthSales> chartData = [];
  Future loaddata() async {
    var jsonResponse;
    await ProductApi.getmonthlist().then((value) => {
          jsonResponse = json.decode(value),
          setState(() {
            for (Map<String, dynamic> i in jsonResponse) {
              chartData.add(MonthSales.fromJson(i));
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
        future: ProductApi.getmonthlist(),
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
                title: ChartTitle(text: 'Month Sales'),
                series: <ChartSeries<MonthSales, String>>[
                  SplineAreaSeries<MonthSales, String>(
                    markerSettings: const MarkerSettings(isVisible: true),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelAlignment: ChartDataLabelAlignment.top,
                    ),
                    dataSource: chartData,
                    color: Colors.blue,
                    xValueMapper: (MonthSales sales, _) => sales.month,
                    yValueMapper: (MonthSales sales, _) => sales.sales,
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

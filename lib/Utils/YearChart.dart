// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:convert';

import 'package:exhibition/Model/YearSales.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Services/Productapi.dart';

class YearChart extends StatefulWidget {
  const YearChart({
    Key? key,
  }) : super(key: key);

  @override
  State<YearChart> createState() => _YearChartState();
}

class _YearChartState extends State<YearChart> {
  List<YearSales> chartData = [];
  var loaddaydata;
  Future loaddata() async {
    var jsonResponse;
    await ProductApi.getyearlist().then((value) => {
          jsonResponse = json.decode(value),
          if (mounted)
            {
              setState(() {
                for (Map<String, dynamic> i in jsonResponse) {
                  chartData.add(YearSales.fromJson(i));
                }
              })
            }
        });
    return chartData;
  }

  @override
  void initState() {
    super.initState();
    loaddaydata = loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loaddaydata,
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
                title: ChartTitle(text: 'Year Sales'),
                series: <ChartSeries<YearSales, String>>[
                  SplineAreaSeries<YearSales, String>(
                    markerSettings: const MarkerSettings(isVisible: true),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelAlignment: ChartDataLabelAlignment.top,
                    ),
                    dataSource: chartData,
                    color: Colors.blue,
                    xValueMapper: (YearSales sales, _) => sales.month,
                    yValueMapper: (YearSales sales, _) => sales.sales,
                    animationDuration: 2000,
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

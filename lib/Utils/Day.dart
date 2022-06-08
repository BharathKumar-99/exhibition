import 'dart:convert';

import 'package:exhibition/Model/DaySales.dart';
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
  List<DaySales> chartData = [];
  Future loaddata() async {
    var jsonResponse;
    await ProductApi.getdaylist().then((value) => {
          jsonResponse = json.decode(value),
          if (mounted)
            {
              setState(() {
                for (Map<String, dynamic> i in jsonResponse) {
                  chartData.add(DaySales.fromJson(i));
                }
              })
            }
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
        future: ProductApi.getdaylist(),
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
                title: ChartTitle(text: 'Day Sales'),
                series: <ChartSeries<DaySales, String>>[
                  SplineAreaSeries<DaySales, String>(
                    markerSettings: const MarkerSettings(isVisible: true),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelAlignment: ChartDataLabelAlignment.top,
                    ),
                    dataSource: chartData,
                    color: Colors.blue,
                    xValueMapper: (DaySales sales, _) => sales.month,
                    yValueMapper: (DaySales sales, _) => sales.sales,
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

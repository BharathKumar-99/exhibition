// ignore_for_file: file_names

class MonthSales {
  MonthSales(this.month, this.sales);

  final String month;
  final int sales;

  factory MonthSales.fromJson(Map<String, dynamic> parsedJson) {
    return MonthSales(
      parsedJson['Week'].toString(),
      parsedJson['Value'],
    );
  }
}

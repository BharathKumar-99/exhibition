// ignore_for_file: file_names

class YearSales {
  YearSales(this.month, this.sales);

  final String month;
  final int sales;

  factory YearSales.fromJson(Map<String, dynamic> parsedJson) {
    return YearSales(
      parsedJson['Month'].toString(),
      parsedJson['Value'],
    );
  }
}

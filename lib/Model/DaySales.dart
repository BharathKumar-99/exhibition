// ignore_for_file: file_names

class DaySales {
  DaySales(this.month, this.sales);

  final String month;
  final int sales;

  factory DaySales.fromJson(Map<String, dynamic> parsedJson) {
    return DaySales(
      parsedJson['time'].toString(),
      parsedJson['Value'],
    );
  }
}

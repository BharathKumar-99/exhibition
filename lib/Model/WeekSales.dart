// ignore_for_file: file_names

class Weeksales {
  Weeksales(this.month, this.sales);

  final String month;
  final int sales;

  factory Weeksales.fromJson(Map<String, dynamic> parsedJson) {
    return Weeksales(
      parsedJson['day'].toString(),
      parsedJson['Value'],
    );
  }
}

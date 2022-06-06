class Weeksales {
  Weeksales(this.month, this.sales);

  final String month;
  final int sales;

  factory Weeksales.fromJson(Map<String, dynamic> parsedJson) {
    return Weeksales(
      parsedJson['month'].toString(),
      parsedJson['sales'],
    );
  }
}

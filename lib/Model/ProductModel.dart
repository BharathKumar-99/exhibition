// ignore_for_file: file_names

class ProductModel {
  String? productin;
  String? productout;
  List<Day>? day;
  List<Week>? week;
  List<Month>? month;
  List<Year>? year;

  ProductModel(
      {this.productin,
      this.productout,
      this.day,
      this.week,
      this.month,
      this.year});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productin = json['productin'];
    productout = json['productout'];
    if (json['Day'] != null) {
      day = <Day>[];
      json['Day'].forEach((v) {
        day!.add(Day.fromJson(v));
      });
    }
    if (json['Week'] != null) {
      week = <Week>[];
      json['Week'].forEach((v) {
        week!.add(Week.fromJson(v));
      });
    }
    if (json['Month'] != null) {
      month = <Month>[];
      json['Month'].forEach((v) {
        month!.add(Month.fromJson(v));
      });
    }
    if (json['Year'] != null) {
      year = <Year>[];
      json['Year'].forEach((v) {
        year!.add(Year.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productin'] = productin;
    data['productout'] = productout;
    if (day != null) {
      data['Day'] = day!.map((v) => v.toJson()).toList();
    }
    if (week != null) {
      data['Week'] = week!.map((v) => v.toJson()).toList();
    }
    if (month != null) {
      data['Month'] = month!.map((v) => v.toJson()).toList();
    }
    if (year != null) {
      data['Year'] = year!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Day {
  String? time;
  String? value;

  Day({this.time, this.value});

  Day.fromJson(Map<String, dynamic> json) {
    time = json['Time'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Time'] = time;
    data['Value'] = value;
    return data;
  }
}

class Week {
  String? day;
  String? value;

  Week({this.day, this.value});

  Week.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['Value'] = value;
    return data;
  }
}

class Month {
  String? week;
  String? value;

  Month({this.week, this.value});

  Month.fromJson(Map<String, dynamic> json) {
    week = json['Week'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Week'] = week;
    data['Value'] = value;
    return data;
  }
}

class Year {
  String? month;
  String? value;

  Year({this.month, this.value});

  Year.fromJson(Map<String, dynamic> json) {
    month = json['Month'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Month'] = month;
    data['Value'] = value;
    return data;
  }
}

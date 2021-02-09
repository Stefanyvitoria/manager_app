class Expense {
  String date;
  num value;
  String considerations;

  Expense({this.date, this.value, this.considerations});

  Expense.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    value = json['value'];
    considerations = json['considerations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['value'] = this.value;
    data['considerations'] = this.considerations;
    return data;
  }
}

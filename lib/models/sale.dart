class Sale {
  String id;
  String employee;
  String date;
  String product;
  String value;
  String productAmount;
  String refUID;
  Sale({
    this.employee,
    this.product,
    this.date,
    this.value,
    this.productAmount,
    this.id,
    this.refUID,
  });

  Sale.fromJson(Map<String, dynamic> json, uid) {
    employee = json['employee'];
    value = json['value'];
    refUID = json['refUID'];
    id = uid;
    productAmount = json['productAmount'];
    date = json['date'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['value'] = this.value;
    data['refUID'] = this.refUID;
    data['productAmount'] = this.productAmount;
    data['date'] = this.date;
    data['employee'] = this.employee;
    return data;
  }
}

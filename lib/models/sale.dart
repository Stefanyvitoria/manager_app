class Sale {
  String id;
  String employee;
  String date;
  String product;
  String value;
  String productAmount;
  String ceoid;
  String employeeid;
  Sale({
    this.employee,
    this.product,
    this.date,
    this.value,
    this.productAmount,
    this.id,
    this.ceoid,
    this.employeeid,
  });

  Sale.fromJson(Map<String, dynamic> json, uid) {
    employee = json['employee'];
    value = json['value'];
    ceoid = json['refUID'];
    id = uid;
    productAmount = json['productAmount'];
    date = json['date'];
    product = json['product'];
    employeeid = json['employeeid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['value'] = this.value;
    data['ceoid'] = this.ceoid;
    data['employeeid'] = this.employeeid;
    data['productAmount'] = this.productAmount;
    data['date'] = this.date;
    data['employee'] = this.employee;
    return data;
  }
}

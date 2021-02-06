class Employee {
  String name;
  String occupation;
  String admissionDate;
  String company;

  Employee({this.name, this.occupation, this.admissionDate, this.company});

  Employee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    occupation = json['occupation'];
    admissionDate = json['admissionDate'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['occupation'] = this.occupation;
    data['admissionDate'] = this.admissionDate;
    data['company'] = this.company;
    return data;
  }
}

class Ceo {
  String name;
  String email;
  String password;
  String phone;
  String company;
  String uid;

  Ceo(
      {this.name,
      this.email,
      this.password,
      this.phone,
      this.company,
      this.uid});

  Ceo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    company = json['company'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['company'] = this.company;
    data['uid'] = this.uid;
    return data;
  }
}

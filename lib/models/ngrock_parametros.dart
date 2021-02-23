class Params {
  List xCoordinates;
  List yCoordinates;
  List xPredict;
  List yPredict;

  Params({this.xCoordinates, this.yCoordinates, this.xPredict});

  Params.fromJson(Map<String, dynamic> json) {
    xCoordinates = json['x_coordinates'];
    yCoordinates = json['y_coordinates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['x_coordinates'] = this.xCoordinates;
    data['y_coordinates'] = this.yCoordinates;
    data['x_predict'] = this.xPredict;
    return data;
  }
}

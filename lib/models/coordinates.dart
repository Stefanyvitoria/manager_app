class Coordinates {
  List xs;
  List ys;
  Coordinates({
    this.xs,
    this.ys,
  });
  Coordinates.fromJson(Map<String, dynamic> json) {
    xs = json['x_coordinates'];
    ys = json['y_coordinates'];
  }
}

class Points {
  String name;
  String x;

  Points({this.x, this.name});
}

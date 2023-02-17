class Attendance {
  Object? id;
  String name;
  String? details;
  String time;

  Attendance({this.id, required this.name, this.details, required this.time});

  Map<String, dynamic> toMap() {
    return {'name': name, 'details': details ?? '', 'time': time};
  }

  static Attendance toDataModel(Map<String, dynamic> data) =>
      Attendance(id: data['id'],
          name: data['name'], details: data['details'], time: data['time']);
}

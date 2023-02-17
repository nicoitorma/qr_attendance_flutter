class Student {
  final String idNum;
  final String name;
  final String dept;
  final int parentId;

  const Student(
      {required this.idNum,
      required this.name,
      required this.dept,
      required this.parentId});

  Map<String, dynamic> toMap() {
    return {
      'idNum': idNum,
      'name': name,
      'dept': dept,
    };
  }

  @override
  String toString() {
    return 'Student{id: $idNum, name: $name, dept: $dept, pId: $parentId}';
  }
}

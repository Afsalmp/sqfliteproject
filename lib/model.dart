class Studentmodel {
  int? id;
  String name;
  String age;

  Studentmodel({
    required this.name,
    required this.age,
     this.id
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }
}
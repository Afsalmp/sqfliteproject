
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

ValueNotifier<List<Studentmodel>> studentlist = ValueNotifier([]);
late Database _db;
initilizeDatabse() async {
  _db = await openDatabase('student.db', version: 1,
      onCreate: (db, version) async {
    await db.execute(
        'CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT, age TEXT)');
  });
}
void addStudent(Studentmodel value) async {
  final id = await _db.rawInsert(
      'INSERT INTO student(name, age) VALUES(?, ?)',
      [value.name, value.age]);

  value.id = id;
  studentlist.value.add(value);
  studentlist.notifyListeners();
}
void deleteStudent(int studentId) async {
  await _db.rawDelete('DELETE FROM student WHERE id = ?', [studentId]);
  studentlist.value.removeWhere((student) => student.id == studentId);
  studentlist.notifyListeners();
}


getAllStudent() async {
  final results = await _db.rawQuery('SELECT * FROM student');
  final students = results.map((mapp) {
    return Studentmodel(
      id: mapp['id']as int,
      name: mapp['name']as String,
      age: mapp['age']as String,
    );
  }).toList();
  studentlist.value.clear();
  studentlist.value.addAll(students);
  studentlist.notifyListeners();
}
void updateStudent(Studentmodel student) async {
  await _db.update(
    'student',
    student.toMap(),
    where: 'id = ?',
    whereArgs: [student.id],
  );
}


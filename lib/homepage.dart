import 'package:flutter/material.dart';
import 'package:sqfliteproject/db_helper.dart';

import 'model.dart';

class pageone extends StatefulWidget {
  const pageone({super.key});

  @override
  State<pageone> createState() => _pageoneState();
}

class _pageoneState extends State<pageone> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'TEST APP',
          style: TextStyle(color: Color.fromARGB(255, 65, 37, 37)),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 0, 78, 71),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Name',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      controller: ageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Age',
                        labelText: 'Age',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Buttonpress();
                      },
                      child: const Text(
                        'ADD',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ValueListenableBuilder(
                    valueListenable: studentlist,
                    builder: (BuildContext ctx, List<Studentmodel> studentlist1,
                        Widget? child) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final data = studentlist1[index];
                          return Card(
                            color: const Color.fromARGB(255, 177, 215, 194),
                            child: ListTile(
                              title: Text("Name :${data.name}",style: const TextStyle(fontSize: 20),),
                              subtitle: Text("Age  :${data.age}",style: const TextStyle(fontSize: 20),),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      editStudentDialog(data);
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deleteStudent(data.id!);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 5,
                          );
                        },
                        itemCount: studentlist1.length,
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Buttonpress() {
    final name = nameController.text;
    final age = ageController.text;
    if (age.isNotEmpty && name.isNotEmpty) {
      final student = Studentmodel(
        name: name,
        age: age,
      );
      addStudent(student);
      nameController.clear();
      ageController.clear();
    }
  }

  Future<void> editStudentDialog(Studentmodel student) async {
    final nameController = TextEditingController(text: student.name);
    final ageController = TextEditingController(text: student.age);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 158, 182, 159),
          title: const Text('Edit Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name' ,
                  labelStyle:TextStyle(fontSize: 30,color: Colors.white70),
                ),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  labelStyle:TextStyle(fontSize: 30,color: Colors.white70),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel',style: TextStyle(fontSize: 22),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save',style: TextStyle(fontSize: 22),),
              onPressed: () {
                final newName = nameController.text;
                final newAge = ageController.text;

                if (newName.isNotEmpty && newAge.isNotEmpty) {
                  student.name = newName;
                  student.age = newAge;
                  updateStudent(student);

                  studentlist.notifyListeners();

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

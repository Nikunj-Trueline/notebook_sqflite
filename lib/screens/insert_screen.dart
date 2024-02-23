import 'package:flutter/material.dart';
import 'package:notebook_sqflite/sqflite/servicies.dart';
import 'package:sqflite/sqflite.dart';

class InsertScreen extends StatefulWidget {
  const InsertScreen({super.key});

  @override
  State<InsertScreen> createState() => _InsertScreenState();
}

class _InsertScreenState extends State<InsertScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: insertAppbar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 40,
        ),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Enter Title",
              ),
              style: const TextStyle(fontSize: 30, color: Colors.black),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: "Enter Description"),
              style: const TextStyle(fontSize: 30, color: Colors.black),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 80, right: 80),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1434A4),
                    fixedSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  insertData(
                      title: titleController.text.toString().trim(),
                      description:
                          descriptionController.text.toString().trim());
                },
                child: const Text('INSERT DATA ',
                    style: TextStyle(color: Colors.white, fontSize: 30)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> insertData(
      {required String title, required String description}) async {
    Database db = await DatabaseHelper.dbHelper();

    await db.rawInsert(
        'INSERT INTO Notes(title, description) VALUES("$title","$description")');

    print("data insert successfully");

    if (!mounted) return;
    Navigator.pop(context);
  }
}

AppBar insertAppbar() {
  return AppBar(
    backgroundColor: const Color(0xff1434A4),
    title: const Text(
      'I N S E R T  S C R E E N ',
      style: TextStyle(
          fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white),
    ),
    centerTitle: true,
  );
}

import 'package:flutter/material.dart';
import 'package:notebook_sqflite/screens/home_screen.dart';
import 'package:notebook_sqflite/sqflite/servicies.dart';
import 'package:sqflite/sqflite.dart';

class EditScreen extends StatefulWidget {
  final int id;
  final String title;
  final String description;

  const EditScreen(
      {super.key,
      required this.id,
      required this.title,
      required this.description});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: editAppbar(),
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
                hintText: "Enter Title ",
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
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1434A4),
                  fixedSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  updateData(
                          title: titleController.text.toString().trim(),
                          description:
                              descriptionController.text.toString().trim(),
                          id: widget.id)
                      .then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                        (route) => false);
                  });
                },
                child: const Text('UPDATE DATA ',
                    style: TextStyle(color: Colors.white, fontSize: 30)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateData(
      {required String title,
      required String description,
      required int id}) async {
    Database db = await DatabaseHelper.dbHelper();

    db.rawUpdate(
        "UPDATE Notes SET title = '$title', description = '$description' WHERE id = $id");

    print("data update successfully");
  }
}

AppBar editAppbar() {
  return AppBar(
    backgroundColor: const Color(0xff1434A4),
    title: const Text(
      'E D I T   S C R E E N ',
      style: TextStyle(
          fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white),
    ),
    centerTitle: true,
  );
}

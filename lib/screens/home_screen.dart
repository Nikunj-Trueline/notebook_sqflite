import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notebook_sqflite/screens/edit_screen.dart';
import 'package:notebook_sqflite/screens/insert_screen.dart';
import 'package:notebook_sqflite/sqflite/servicies.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void afterRefreshData() {
    setState(() {
      getData();
    });
  }

  List userdata = [];

  Future<void> getData() async {
    Database db = await DatabaseHelper.dbHelper();

    List<Map> data = await db.rawQuery("SELECT * FROM Notes");

    userdata = data;
    print(userdata);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context: context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 900,
                child: ListView.builder(
                  itemCount: userdata.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 12, bottom: 5),
                      child: Container(
                        height: 130,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: splashGradient,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                userdata[index]["id"].toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            title: Text(
                              "TITLE : ${userdata[index]["title"]}",
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              "DESC : ${userdata[index]['description']}",
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                deleteData(id: userdata[index]['id'])
                                    .then((value) {
                                  setState(() {
                                    afterRefreshData();
                                  });
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditScreen(
                                      id: userdata[index]["id"],
                                      title: userdata[index]["title"],
                                      description: userdata[index]
                                          ["description"],
                                    ),
                                  ),
                                  (route) => false);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InsertScreen(),
              ));
        },
        backgroundColor: const Color(0xff1434A4),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Future<void> deleteData({required int id}) async {
    Database db = await DatabaseHelper.dbHelper();

    db.rawDelete('DELETE FROM Notes WHERE id = $id');

    print("delete data successfully");
  }
}

AppBar homeAppBar({required BuildContext context}) {
  return AppBar(
    backgroundColor: const Color(0xff1434A4),
    title: const Text(
      'H O M E S C R E E N ',
      style: TextStyle(
          fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white),
    ),
    centerTitle: true,
  );
}

/*
  IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.black,
                        size: 40,
                      ))
 */

/*

 actions: [
      IconButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SigninScreen(),
              ),
              (route) => false);
        },
        icon: const Icon(Icons.logout),
      ),
    ],

 */

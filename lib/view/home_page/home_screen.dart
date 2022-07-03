import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/view/home_page/widgets/add_screen.dart';
import 'package:note_app/view/home_page/widgets/note_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: NoteSection(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/add_page_conroller.dart';

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  final tittleController = TextEditingController();
  final contentController = TextEditingController();

  final controller = Get.put(AddPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const Text(
              'AddScreen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: tittleController,
              decoration: const InputDecoration(
                  labelText: 'Tittle', border: InputBorder.none),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: contentController,
              decoration: const InputDecoration(
                  labelText: 'Content', border: InputBorder.none),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  controller.selectColor(context);
                },
                icon: const Icon(Icons.color_lens),
                label: const Text('Select Color')),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addNotes(
            tittleController.text,
            contentController.text,
          );
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/add_page_conroller.dart';

class ViewScreen extends StatelessWidget {
  final int index;
  // final List<DocumentChange<Map<String, dynamic>>> events;

  ViewScreen({
    Key? key,
    required this.index,
    //  required this.events
  }) : super(key: key);

  final controller = Get.put(AddPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Notes').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              final events = snapshot.data!.docChanges;
              final tittleController = TextEditingController(
                text: '${events[index].doc['title']}',
              );
              final contentController = TextEditingController(
                  text: '${events[index].doc['content']}');
              return ListView(
                children: [
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
                        controller.editNote(events, index,
                            tittleController.text, contentController.text);
                            controller.update();
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit_Text')),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    )));
  }
}

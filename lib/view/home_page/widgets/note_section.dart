import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/add_page_conroller.dart';
import 'package:note_app/view/core/border_radius.dart';
import 'package:note_app/view/home_page/view_screen/view_screen.dart';

class NoteSection extends StatelessWidget {
  const NoteSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GetBuilder<AddPageController>(
        init: AddPageController(),
        builder: (controller) {
          return StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Notes').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  final events = snapshot.data!.docChanges;
                  return GridView.builder(
                      shrinkWrap: true,
                      itemCount: events.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 300 / 350),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(ViewScreen(index: index));
                          },
                          onLongPress: () {
                            Get.defaultDialog(
                              content: Text(''),
                                title: 'Do you Want to Delete',
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      controller.deleteNote(events, index);
                                      controller.update();
                                    },
                                  ),
                                ]);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color(int.parse(
                                          events[index]
                                              .doc['color']
                                              .substring(1, 7),
                                          radix: 16) +
                                      0xFF000000),
                                  borderRadius: kradius10),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      events[index].doc['title'],
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      events[index].doc['content'],
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      });
                } else {
                  return const Center(
                    child: Text('No Noted Addeds'),
                  );
                }
              });
        },
      ),
    );
  }
}

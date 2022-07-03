import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class AddPageController extends GetxController {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  void selectColor(context) {
    showDialog(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: AlertDialog(
                content: ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: (color) {
                    pickerColor = color;
                  },
                ),
                actions: [
                  
                  TextButton(
                      onPressed: () {
                        currentColor = pickerColor;
                        update();
                        Get.back();
                      },
                      child: const Text('Select Color')),
                ],
              ),
            ));
  }

  void addNotes(
    text,
    tittle,
  ) {
    String newBgColor = '#${currentColor.value.toRadixString(16).substring(2)}';

    FirebaseFirestore.instance.collection('Notes').add({
      'title': text,
      'content': tittle,
      'color': newBgColor,
    });
    update();
    Get.back();
  }

  void deleteNote(
      List<DocumentChange<Map<String, dynamic>>> events, index) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.delete(events[index].doc.reference);
    });
    update();
    Get.back();
  }

  void editNote(List<DocumentChange<Map<String, dynamic>>> events, index, title,
      text) async {
    await FirebaseFirestore.instance
        .collection('Notes')
        .doc(events[index].doc.id)
        .set({
      'title': title,
      'content': text,
      'color': events[index].doc['color'],
    });
    update();
    Get.back();
  }
}

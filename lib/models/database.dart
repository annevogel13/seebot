import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final db = FirebaseFirestore.instance;

  addArea(String title, String description, List<double> coordinates) async {
    await db.collection('areas').add({
      'title': title,
      'description': description,
      'coordinates': coordinates
    }).then((DocumentReference document) {
      print(document.id);
    }).catchError((e) {
      print(e);
    });
  }

  Future<List<Map<String, dynamic>>> getAreas() async {
    List<Map<String, dynamic>> areas = [];

    await db.collection('areas').get().then((event) {
      for (var doc in event.docs) {
        areas.add({
          'id': doc.id,
          'title': doc['title'],
          'description': doc['description'],
          'coordinates': doc['coordinates']
        });
      }
    });
    
    return areas;
  }
}

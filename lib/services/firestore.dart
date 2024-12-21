import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:seebot/models/areas.dart';

final geo = GeoFlutterFire();
FirestoreService firestoreDB = FirestoreService();

class FirestoreService {
  // get areas
  final CollectionReference _areasCollection =
      FirebaseFirestore.instance.collection('areas');

  //create area
  Future<void> addArea(title, description, status, coordinates) {
    // turn coordinates into a json string
    final markers = jsonEncode(coordinates.toList());

    return _areasCollection.add({
      'title': title,
      'description': description,
      'status': status,
      'markers': markers
    });
  }

  // read
  Future<List<Area>> getAreas() async {
    QuerySnapshot querySnapshot = await _areasCollection.get();
    final documents = querySnapshot.docs
        .map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return data;
        })
        
        .toList();

    final List<Area> areas = [];
    // changing the markers from json string to list of LatLng
    for (var element in documents) {
      final markers = jsonDecode(element['markers']);
      final List<List<double>> markersList = List<List<double>>.from(
        markers.map((marker) => List<double>.from(marker.map((coord) => coord.toDouble())))
      );
      final areaInstance = Area(id : element['id'], title : element['title'], description:  element['description'],
          status : element['status'], coordinates:  markersList);	 
      areas.add(areaInstance); // add the area to the list
    }
    // return the list of documents
    return areas;
  }

  // update
  Future<void> updateArea(String docID, area) {
    return _areasCollection.doc(docID).update(area);
  }

  // delete
  Future<void> deleteArea(String docID) {
    return _areasCollection.doc(docID).delete();
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:geoflutterfire2/geoflutterfire2.dart';
 
final geo = GeoFlutterFire();

class FirestoreService {

  // get areas 
  final CollectionReference _areasCollection = FirebaseFirestore.instance.collection('areas');

  //create area
  Future <void> addArea(title, description, status, coordinates){
    // turn coordinates into a json string 
    final markers = jsonEncode(coordinates); 

    return _areasCollection.add({'title': title, 'description' : description, 'status' : status, 'markers' : markers});
  }

  // read 
  Stream<QuerySnapshot> getAreaStream(){
    final areaStream = _areasCollection.orderBy('name', descending: true).snapshots();
    return areaStream; 
  }
  // update 
  Future<void> updateArea(String docID, area){
    return _areasCollection.doc(docID).update(area);
  }

  // delete 
  Future<void> deleteArea(String docID){
    return _areasCollection.doc(docID).delete();
  }
}
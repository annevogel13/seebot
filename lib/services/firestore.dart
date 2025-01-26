import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:seebot/graphs/piechart_graph.dart';
import 'package:seebot/models/areas.dart';

final geo = GeoFlutterFire();
FirestoreService firestoreDB = FirestoreService();

enum CategorySeebot {
  driving,
  mowing,
  calculatingDirection,
  awaitingInstructions,
}

class FirestoreService {
  // get areas
  final CollectionReference _areasCollection =
      FirebaseFirestore.instance.collection('areas');

  final CollectionReference _sessionCollection =
      FirebaseFirestore.instance.collection('session');

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
    final documents = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }).toList();

    final List<Area> areas = [];
    // changing the markers from json string to list of LatLng
    for (var element in documents) {
      final List<List<double>> markersList = [];

      if (element['markers'].runtimeType == String) {
        // if the markers are in json string format
        final markers = jsonDecode(element['markers']);
        for (var marker in markers) {
          markersList.add([marker[0], marker[1]]);
        }
      } else {
        // if the markers are in list of LatLng format
        for (var marker in element['markers']) {
          final geoPoint = marker['geopoint'];
          markersList.add([geoPoint.latitude, geoPoint.longitude]);
        }
      }

      final areaInstance = Area(
          id: element['id'],
          title: element['title'],
          description: element['description'],
          status: element['status'],
          coordinates: markersList);
      areas.add(areaInstance); // add the area to the list
    }
    // return the list of documents
    return areas;
  }

  Future<Area?> getAreaByTitle(String title) async {
    QuerySnapshot querySnapshot =
        await _areasCollection.where('title', isEqualTo: title).get();

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;

      // changing the markers from json string to list of LatLng
      final List<List<double>> markersList = [];

      if (data['markers'] is String) {
        final markers = jsonDecode(data['markers']);
        for (var marker in markers) {
          markersList.add([marker[0], marker[1]]);
        }
      } else {
        for (var marker in data['markers']) {
          final geoPoint = marker['geopoint'];
          markersList.add([geoPoint.latitude, geoPoint.longitude]);
        }
      }

      return Area(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        status: data['status'],
        coordinates: markersList,
      );
    }
    return null;
  }

  // update
  Future<void> updateArea(String docID, area) {
    return _areasCollection.doc(docID).update(area);
  }

  // delete
  Future<void> deleteArea(String docID) {
    return _areasCollection.doc(docID).delete();
  }

  // get graph data
  Future<List<List<dynamic>>> getGraphData() async {
    QuerySnapshot querySnapshot = await _sessionCollection.get();
    final documents = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }).toList();

    final List<List<dynamic>> graphData = [];
    for (var element in documents) {
      var points = [];

      for (var d in element['datapoints']) {
        points.add([d['Latitude'], d['Longitude']]);
      }

      graphData.add([element['area'], points]);
    }
    return graphData;
  }

  Future<Map<CategorySeebot, int>> getPieChartData() async {
    QuerySnapshot querySnapshot = await _sessionCollection.get();
    final documents = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }).toList();

    final Map<CategorySeebot, int> graphData = {};
    for (var c in categoryColors.keys) {
      graphData[c] = 0;
    }
    for (var element in documents) {
      for (var d in element['datapoints']) {
        switch (d['Annotations']) {
          case 'driving':
            d['Annotations'] = CategorySeebot.driving;
            break;
          case 'mowing':
            d['Annotations'] = CategorySeebot.mowing;
            break;
          case 'calculating direction':
            d['Annotations'] = CategorySeebot.calculatingDirection;
            break;
          case 'awaiting instructions':
            d['Annotations'] = CategorySeebot.awaitingInstructions;
            break;
          default:
            continue;
        }

        if (graphData[d['Annotations']] != null) {
          graphData[d['Annotations']] = graphData[d['Annotations']]! + 1;
        }
      }
    }

    return graphData;
  }
}

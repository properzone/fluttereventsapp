import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttereventsapp/models/event.dart';

class DatabaseServices {
  static Future<void> setEvent(Map<String, dynamic> map) async {
    FirebaseFirestore.instance.collection("appevents").doc().set(map);
  }

  static Future<void> updateEvent(
      Map<String, dynamic> map, String docId) async {
    FirebaseFirestore.instance.collection("appevents").doc(docId).update(map);
  }

  static Stream<List<Event>> eventsStream() {
    return FirebaseFirestore.instance
        .collection("appevents")
        .snapshots()
        .distinct()
        .map(_eventsFromSnapshot);
  }

  static List<Event> _eventsFromSnapshot(QuerySnapshot snap) {
    return snap.docs.map((e) {
      return Event.fromMap(e.data() as Map<String, dynamic>);
    }).toList();
  }

  static Stream<List<Event>> userEventsStream(String uid) {
    return FirebaseFirestore.instance
        .collection("appevents")
        .where("owner", isEqualTo: uid)
        .snapshots()
        .distinct()
        .map(_eventsFromSnapshot);
  }
}

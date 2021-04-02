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
    var rawList = snap.docs.map((e) {
      return Event.fromMap(e.data() as Map<String, dynamic>, e.id);
    }).toList();
    rawList.sort((a, b) => a.eventDateTime.compareTo(b.eventDateTime));
    return rawList;
  }

  static Stream<List<Event>> userEventsStream(String uid) {
    return FirebaseFirestore.instance
        .collection("appevents")
        .where("owner", isEqualTo: uid)
        .snapshots()
        .distinct()
        .map(_eventsFromSnapshot);
  }

  static Future<void> deleteEvent({required Event event}) async {
    await FirebaseFirestore.instance
        .collection("appevents")
        .doc(event.docId)
        .delete();
  }
}

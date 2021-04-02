import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/event.dart';

class DatabaseServices {
  static CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection("appevents");

  static Future<void> setEvent(Map<String, dynamic> map) async {
    await eventsCollection.doc().set(map);
  }

  static Future<void> updateEvent(
    String docId, {
    required Map<String, dynamic> map,
  }) async {
    await eventsCollection.doc(docId).update(map);
  }

  static Stream<List<Event>> eventsStream() {
    return eventsCollection.snapshots().distinct().map(_eventsFromSnapshot);
  }

  static List<Event> _eventsFromSnapshot(QuerySnapshot snap) {
    return snap.docs.map((e) {
      return Event.fromMap(e.data() as Map<String, dynamic>, e.id);
    }).toList();
  }

  static Stream<List<Event>> userEventsStream(String uid) {
    return eventsCollection
        .where("owner", isEqualTo: uid)
        .snapshots()
        .distinct()
        .map(_eventsFromSnapshot);
  }

  static Future<void> deleteEvent({required Event event}) async {
    await eventsCollection.doc(event.docId).delete();
  }
}

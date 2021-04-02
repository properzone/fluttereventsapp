import '../services/database_services.dart';
import '../services/database_services.dart';

class Event {
  String? docId;
  String owner;
  String title;
  String description;
  DateTime insertDateTime;
  DateTime eventDateTime;
  String location;
  EventType eventType;

  Event(
      {this.docId,
      required this.owner,
      required this.description,
      required this.eventDateTime,
      required this.eventType,
      required this.insertDateTime,
      required this.location,
      required this.title});

  static EventType typeFromTitle(String title) {
    EventType eventType = EventType.business;
    EventType.values.forEach((element) {
      if (element.title == title.toLowerCase()) {
        eventType = element;
      }
    });
    return eventType;
  }

  factory Event.fromMap(Map<String, dynamic> map, String? docId) {
    return Event(
      docId: docId,
      owner: map["owner"],
      description: map["description"],
      eventDateTime: DateTime.fromMillisecondsSinceEpoch(
          map["eventDateTime"].seconds * 1000),
      eventType: typeFromTitle(map["eventType"]),
      insertDateTime: DateTime.fromMillisecondsSinceEpoch(
          map["insertDateTime"].seconds * 1000),
      location: map["location"],
      title: map["title"],
    );
  }

  Map<String, dynamic> get toMap {
    return {
      "owner": this.owner,
      "title": this.title,
      "description": this.description,
      "insertDateTime": this.insertDateTime,
      "eventDateTime": this.eventDateTime,
      "location": this.location,
      "eventType": this.eventType.title,
    };
  }

  Future<void> save() async {
    if (docId == null) {
      // New event:
      await DatabaseServices.setEvent(this.toMap);
    } else {
      // Update event:
      await DatabaseServices.updateEvent(this.docId!, map: this.toMap);
    }
  }
}

enum EventType {
  music,
  sports,
  movie,
  philosophy,
  business,
}

extension EventTypeExtension on EventType {
  String get title {
    switch (this) {
      case EventType.music:
        return "music";
      case EventType.sports:
        return "sports";
      case EventType.movie:
        return "movie";
      case EventType.philosophy:
        return "philosophy";
      case EventType.business:
        return "business";

      default:
        return "";
    }
  }

  String get emoji {
    switch (this) {
      case EventType.music:
        return "🎼";
      case EventType.sports:
        return "⚽️";
      case EventType.movie:
        return "🎬";
      case EventType.philosophy:
        return "🧠";
      case EventType.business:
        return "💼";
      default:
        return "";
    }
  }
}

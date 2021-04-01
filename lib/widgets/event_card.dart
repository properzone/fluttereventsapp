import 'package:flutter/material.dart';
import 'package:fluttereventsapp/models/event.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;
  EventCard({required this.event});
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 240,
      margin: EdgeInsets.all(8.0),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title),
                Row(
                  children: [
                    Text(event.eventType.emoji),
                    Text(event.eventType.title),
                  ],
                ),
              ],
            ),
            SizedBox(width: 60),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.description),
                Text(DateFormat.yMMMd().format(event.eventDateTime).toString()),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

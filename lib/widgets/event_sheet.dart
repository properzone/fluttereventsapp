import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';

class EventSheet extends StatelessWidget {
  final Event event;
  EventSheet({required this.event});
  @override
  Widget build(BuildContext context) {
    double _height = context.mediaQuerySize.height;
    double _width = context.mediaQuerySize.width;
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      height: _height * 0.8,
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Name",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(event.title),
          SizedBox(height: 12),
          Text(
            "Location",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(event.location),
          SizedBox(height: 12),
          Text(
            "Event Type",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(event.eventType.emoji),
              Text(event.eventType.title),
            ],
          ),
          SizedBox(height: 12),
          Text(
            "Event Date",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(DateFormat.yMMMd().format(event.eventDateTime).toString()),
          SizedBox(height: 12),
          Text(
            "Event Description",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(event.description),
        ],
      ),
    );
  }
}

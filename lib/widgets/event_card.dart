import 'package:flutter/material.dart';
import 'package:fluttereventsapp/controllers/app_controller.dart';
import 'package:fluttereventsapp/controllers/auth_controller.dart';
import 'package:fluttereventsapp/models/event.dart';
import 'package:fluttereventsapp/widgets/event_sheet.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;
  EventCard({required this.event});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(EventSheet(event: event), isScrollControlled: true);
      },
      child: GetBuilder<AuthController>(builder: (auth) {
        print(auth.user!.uid);
        return Stack(
          children: [
            Container(
              // height: 240,
              margin: EdgeInsets.all(12.0),
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                        Text(DateFormat.yMMMd()
                            .format(event.eventDateTime)
                            .toString()),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 100,
                      margin: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30.0),
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Event Description",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 12),
                          Text(event.description),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ),
            if (auth.user!.uid == event.owner)
              Positioned(
                bottom: 8.0,
                right: 8.0,
                child: GetBuilder<AppController>(
                  builder: (app) => Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          app.editEvent(event: event);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          app.deleteEvent(event: event);
                        },
                      ),
                    ],
                  ),
                ),
              )
          ],
        );
      }),
    );
  }
}

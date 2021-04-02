import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/app_controller.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';

class EventsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = context.mediaQuerySize.height;
    double _width = context.mediaQuerySize.width;
    return GetBuilder<AppController>(
      builder: (app) => Container(
        height: _height,
        width: _width,
        child: StreamBuilder(
            stream: app.eventStream,
            builder: (context, AsyncSnapshot<List<Event>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length == 0) {
                  return Center(child: Text("🥲 No Data Yet!"));
                }
                return ListView.builder(
                    padding: EdgeInsets.only(bottom: 80.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return EventCard(event: snapshot.data![index]);
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get.dart';

import '../controllers/app_controller.dart';
import '../models/event.dart';
import './event_card.dart';

class MyEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = context.mediaQuerySize.height;
    double _width = context.mediaQuerySize.width;
    return GetBuilder<AppController>(
      builder: (app) => Container(
        height: _height,
        width: _width,
        child: StreamBuilder(
            stream: app.userEventStream,
            builder: (context, AsyncSnapshot<List<Event>> snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                if (snapshot.data!.length == 0) {
                  return Center(child: Text("🥲 No Data Yet!"));
                }
                return ListView.builder(
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

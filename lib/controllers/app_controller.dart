import 'package:flutter/material.dart';
import 'package:fluttereventsapp/controllers/auth_controller.dart';
import 'package:fluttereventsapp/controllers/event_controller.dart';
import 'package:fluttereventsapp/models/event.dart';
import 'package:fluttereventsapp/services/database_services.dart';
import 'package:fluttereventsapp/widgets/edit_event.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  AuthController auth = Get.find<AuthController>();
  final _currentPage = 0.obs;
  set currentPage(int value) => this._currentPage.value = value;
  int get currentPage => this._currentPage.value;

  void togglePage(int index) {
    currentPage = index;
  }

  Stream<List<Event>> get eventStream => DatabaseServices.eventsStream();
  Stream<List<Event>> get userEventStream =>
      DatabaseServices.userEventsStream(auth.user!.uid);

  void updateEvent({Event? event}) {
    print('updateEvent ...');

    var _event = event ??
        Event(
          eventDateTime: DateTime.now(),
          insertDateTime: DateTime.now(),
          owner: auth.user!.uid,
        );

    String uniqueKey = UniqueKey().toString();
    EventController eventController = Get.put(EventController(event: _event),
        permanent: false, tag: uniqueKey);
    Get.bottomSheet(
            EditEvent(
              eventController: eventController,
            ),
            isScrollControlled: true)
        .then((value) => Get.delete<EventController>(tag: uniqueKey));
  }

  void deleteEvent({required Event event}) async {
    if (event.docId != null) {
      await event.delete();
      Get.snackbar("Deleted", "The event was deleted successfully");
    }
  }
}

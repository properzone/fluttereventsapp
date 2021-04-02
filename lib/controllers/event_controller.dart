import 'package:flutter/material.dart';
import 'package:fluttereventsapp/controllers/auth_controller.dart';
import 'package:fluttereventsapp/models/event.dart';
import 'package:fluttereventsapp/services/database_services.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  AuthController auth = Get.find<AuthController>();
  Event? event;
  EventController({this.event});

  late TextEditingController titleController;
  late TextEditingController descController;
  late TextEditingController locController;

  @override
  void onInit() {
    titleController = TextEditingController(text: event?.title ?? "");
    title = event?.title ?? "";
    descController = TextEditingController(text: event?.description ?? "");
    location = event?.location ?? "";
    locController = TextEditingController(text: event?.location ?? "");
    description = event?.description ?? "";
    date = event?.eventDateTime ?? DateTime.now();
    type = event?.eventType ?? EventType.business;
    super.onInit();
  }

  String? title;
  String? location;
  String? description;

  Rx<DateTime> _date = DateTime.now().obs;
  RxBool _loading = false.obs;
  Rx<EventType> _type = EventType.business.obs;

  set date(DateTime value) => this._date.value = value;
  set loading(bool value) => this._loading.value = value;
  set type(EventType value) => this._type.value = value;
  DateTime get date => this._date.value;
  bool get loading => this._loading.value;
  EventType get type => this._type.value;

  void setTitle(String input) {
    title = input;
  }

  void setLocation(String input) {
    location = input;
  }

  void setDescription(String input) {
    description = input;
  }

  void selectType(EventType _type) {
    type = _type;
  }

  void selectDate(DateTime _date) {
    date = _date;
  }

  Future<void> submit() async {
    loading = true;

    var _event = event ??
        Event(
          owner: auth.user!.uid,
          description: description!,
          eventDateTime: date,
          eventType: type,
          insertDateTime: DateTime.now(),
          location: location!,
          title: title!,
        );

    await _event.save();

    loading = false;
    Get.close(1);
  }
}

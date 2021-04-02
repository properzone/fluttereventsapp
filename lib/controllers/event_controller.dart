import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/event.dart';
import './auth_controller.dart';

class EventController extends GetxController {
  AuthController auth = Get.find<AuthController>();
  Event event;
  EventController({required this.event});

  late TextEditingController titleController;
  late TextEditingController descController;
  late TextEditingController locController;

  @override
  void onInit() {
    titleController = TextEditingController(text: event.title);
    descController = TextEditingController(text: event.description);
    locController = TextEditingController(text: event.location);
    date = event.eventDateTime;
    type = event.eventType;
    super.onInit();
  }

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
    event.title = input;
  }

  void setLocation(String input) {
    event.location = input;
  }

  void setDescription(String input) {
    event.description = input;
  }

  void selectType(EventType _type) {
    type = _type;
    event.eventType = _type;
  }

  void selectDate(DateTime _date) {
    date = _date;
    event.eventDateTime = _date;
  }

  Future<void> submit() async {
    loading = true;

    await event.save();

    loading = false;
    Get.close(1);
  }
}

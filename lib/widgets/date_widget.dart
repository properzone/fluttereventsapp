import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereventsapp/controllers/event_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    Key? key,
    required this.eventController,
  }) : super(key: key);

  final EventController eventController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8.0)),
            height: 300,
            padding: EdgeInsets.all(16.0),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              minimumYear: 2021,
              initialDateTime: eventController.date,
              onDateTimeChanged: (input) {
                eventController.selectDate(input);
              },
            ),
          ),
        );
      },
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0)),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Event Date  :  "),
              Obx(
                () => Text(
                    DateFormat.yMMMd().format(eventController.date).toString()),
              ),
              Container(
                height: 12.0,
                width: 1.0,
                color: Theme.of(context).disabledColor,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Icon(Icons.edit, size: 16)
            ],
          )),
    );
  }
}

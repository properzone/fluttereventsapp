import 'package:flutter/material.dart';
import 'package:fluttereventsapp/controllers/event_controller.dart';
import 'package:fluttereventsapp/widgets/radio_button.dart';
import 'package:get/get.dart';
import '../models/event.dart';

class TypeWidget extends StatelessWidget {
  const TypeWidget({
    Key? key,
    required this.eventController,
  }) : super(key: key);

  final EventController eventController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        ...EventType.values.map((e) {
          return Obx(
            () => Container(
              child: Expanded(
                child: Column(
                  children: [
                    Text(e.emoji),
                    SizedBox(height: 8.0),
                    Text(
                      e.title.capitalizeFirst!,
                      style: TextStyle(fontSize: 10),
                    ),
                    CustomRadioButton(
                        active: eventController.type == e,
                        onTap: () {
                          eventController.selectType(e);
                        })
                  ],
                ),
              ),
            ),
          );
        }).toList()
      ],
    );
  }
}

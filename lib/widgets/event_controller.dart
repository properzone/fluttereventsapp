import 'package:flutter/material.dart';

import '../controllers/event_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.formKey,
    required this.eventController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final EventController eventController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            child: ElevatedButton.icon(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await eventController.submit();
                  }
                },
                icon: Icon(Icons.save),
                label: Text("Submit")),
          ),
        ),
      ],
    );
  }
}

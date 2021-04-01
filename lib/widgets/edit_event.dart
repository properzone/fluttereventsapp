import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereventsapp/controllers/event_controller.dart';
import 'package:fluttereventsapp/models/event.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class EditEvent extends StatefulWidget {
  EventController eventController;
  EditEvent({required this.eventController});
  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late FocusNode _node1;
  late FocusNode _node2;
  late FocusNode _node3;
  late FocusNode _node4;
  late FocusNode _node5;

  @override
  void initState() {
    _node1 = FocusNode();
    _node2 = FocusNode();
    _node3 = FocusNode();
    _node4 = FocusNode();
    _node5 = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = context.mediaQuerySize.height;
    double _width = context.mediaQuerySize.width;
    return Container(
      color: Colors.white,
      width: _width,
      height: _height * 0.8,
      padding: EdgeInsets.all(32.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              maxLines: 1,
              onChanged: (input) {
                widget.eventController.setTitle(input);
              },
              decoration: _buildInputDecoration("Event Name"),
              validator: (input) {
                if (input != null) {
                  if (input.isNotEmpty) {
                  } else {
                    return "This Field is required";
                  }
                } else {
                  return "This Field is required";
                }
              },
            ),
            SizedBox(height: 8.0),
            TextFormField(
              maxLines: 1,
              onChanged: (input) {
                widget.eventController.setLocation(input);
              },
              decoration: _buildInputDecoration("Location"),
              validator: (input) {
                if (input != null) {
                  if (input.isNotEmpty) {
                  } else {
                    return "This Field is required";
                  }
                } else {
                  return "This Field is required";
                }
              },
            ),
            SizedBox(height: 8.0),
            TextFormField(
              maxLines: 3,
              onChanged: (input) {
                widget.eventController.setDescription(input);
              },
              decoration: _buildInputDecoration("Description"),
              validator: (input) {
                if (input != null) {
                  if (input.isNotEmpty) {
                  } else {
                    return "This Field is required";
                  }
                } else {
                  return "This Field is required";
                }
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                ...EventType.values.map((e) {
                  return Obx(
                    () => Container(
                      width: 70,
                      child: Column(
                        children: [
                          Text(e.emoji),
                          SizedBox(height: 8.0),
                          Text(
                            e.title.capitalizeFirst!,
                            style: TextStyle(fontSize: 10),
                          ),
                          CustomRadioButton(
                              active: widget.eventController.type == e,
                              onTap: () {
                                widget.eventController.selectType(e);
                              })
                        ],
                      ),
                    ),
                  );
                }).toList()
              ],
            ),
            GestureDetector(
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
                      initialDateTime: widget.eventController.date,
                      onDateTimeChanged: (input) {
                        widget.eventController.selectDate(input);
                      },
                    ),
                  ),
                );
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0)),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Event Date  :  "),
                      Obx(
                        () => Text(DateFormat.yMMMd()
                            .format(widget.eventController.date)
                            .toString()),
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
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    child: ElevatedButton.icon(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await widget.eventController.submit();
                          }
                        },
                        icon: Icon(Icons.save),
                        label: Text("Submit")),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      fillColor: Colors.grey[300],
      filled: true,
      labelText: label,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    Key? key,
    required this.active,
    required this.onTap,
  }) : super(key: key);
  final bool active;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap(),
      child: Container(
        height: 18.0,
        width: 18.0,
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        padding: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 18.0,
          width: 18.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withOpacity(0)),
        ),
      ),
    );
  }
}

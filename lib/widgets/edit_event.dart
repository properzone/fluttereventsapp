import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/event_controller.dart';
import './type_widget.dart';
import './date_widget.dart';
import './event_controller.dart';

class EditEvent extends StatefulWidget {
  final EventController eventController;
  EditEvent({required this.eventController});
  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late FocusNode _node1;
  late FocusNode _node2;
  late FocusNode _node3;

  @override
  void initState() {
    _node1 = FocusNode();
    _node2 = FocusNode();
    _node3 = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _node1.dispose();
    _node2.dispose();
    _node3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = context.mediaQuerySize.height;
    double _width = context.mediaQuerySize.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: Colors.white,
        width: _width,
        height: _height * 0.8,
        padding: EdgeInsets.all(32.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  focusNode: _node1,
                  controller: widget.eventController.titleController,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
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
                  onEditingComplete: () {
                    _node2.requestFocus();
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  focusNode: _node2,
                  textInputAction: TextInputAction.next,
                  controller: widget.eventController.locController,
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
                  onEditingComplete: () {
                    _node3.requestFocus();
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  focusNode: _node3,
                  controller: widget.eventController.descController,
                  maxLines: 3,
                  onChanged: (input) {
                    widget.eventController.setDescription(input);
                  },
                  decoration: _buildInputDecoration("Description"),
                  validator: (input) {
                    return _validator(input);
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
                SizedBox(height: 16.0),
                TypeWidget(eventController: widget.eventController),
                DateWidget(eventController: widget.eventController),
                SubmitButton(
                  formKey: formKey,
                  eventController: widget.eventController,
                )
              ],
            ),
          ),
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

  String? _validator(String? input) {
    if (input != null) {
      if (input.isNotEmpty) {
      } else {
        return "This Field is required";
      }
    } else {
      return "This Field is required";
    }
  }
}

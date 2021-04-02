import 'package:flutter/material.dart';

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

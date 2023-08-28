import 'package:flutter/material.dart';

import '../../core.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final double? height;
  final double? width;
  final Widget icon;
  final void Function() onPressed;

  CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.icon,
      this.height,
      this.width})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: white,
        padding: EdgeInsets.all(paddingSizeExtraSmall),
        elevation: 0.0,
        fixedSize: Size(widget.width ?? SizeConfig(context).appWidth(100),
            widget.height ?? 45.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sizeSmall),
        ),
      ),
      onPressed: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingsizeMedium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon,
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      widget.text,
                      style: buttonTextStyle,
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

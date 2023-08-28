import 'package:flutter/material.dart';
import 'package:truthordare/core/core.dart';

class CustomTitle extends StatelessWidget {
  String title;
  bool? canBack = false;
  CustomTitle({Key? key, required this.title, this.canBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: sizeMedium),
      child: Row(
        children: [
          if (canBack == true)
            Container(
              width: 50,
              height: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: titleTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (canBack == true)
            SizedBox(
              width: 50,
              height: 38,
            )
        ],
      ),
    );
  }
}

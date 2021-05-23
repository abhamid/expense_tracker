import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String title;
  final Function onPressedCallBack;

  AdaptiveButton({this.title, this.onPressedCallBack});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              this.title,
              style: Theme.of(context).textTheme.title,
            ),
            onPressed: onPressedCallBack)
        : FlatButton(
            onPressed: onPressedCallBack,
            child: Text(
              this.title,
              style: Theme.of(context).textTheme.title,
            ),
          );
  }
}

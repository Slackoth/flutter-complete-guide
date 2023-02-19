import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  
  const AdaptiveTextButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? 
      CupertinoButton(onPressed: onPressed, child: Text(text)) 
      : TextButton(onPressed: onPressed, child: Text(text));
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySeparator extends StatelessWidget{

  bool isDark=true;
  @override
  Widget build(BuildContext context) {
    isDark=Theme.of(context).brightness==Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 3,
        decoration: BoxDecoration(
            color: isDark?Colors.white:Colors.blueGrey
        ),
      ),
    );
  }

}
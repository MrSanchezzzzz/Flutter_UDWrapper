import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySeparator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 3,
        decoration: BoxDecoration(
            color: Colors.white
        ),
      ),
    );
  }

}
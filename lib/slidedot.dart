import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
 * For creating dots 
 */
class SlideDot extends StatelessWidget{
  bool isActive;
  SlideDot(this.isActive);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      margin: EdgeInsets.symmetric(horizontal: 10),
      duration: Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue[900] : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }

}
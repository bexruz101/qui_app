import 'package:flutter/material.dart';

class RectangleCont extends StatelessWidget {
  const RectangleCont({super.key, required this.count, required this.color, required this.txt});

  final int count;
  final Color color;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 160,
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15,),
      decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          Text(txt),
        ],
      ),
    );
  }
}

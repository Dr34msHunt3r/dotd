import 'package:flutter/material.dart';

Widget crashButton(context){
  return FloatingActionButton(
    child: Icon(Icons.priority_high),
      backgroundColor: Colors.red,
      onPressed: (){
      throw Exception("Big Crash: There were too many ducks!");
      }
  );
}
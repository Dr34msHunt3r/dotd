import 'package:flutter/material.dart';

Widget crashButton(context){
  return FloatingActionButton(
    child: Icon(Icons.add),
      backgroundColor: Colors.red,
      onPressed: (){
      print("Big Crash: There were too many ducks!");
      }
  );
}
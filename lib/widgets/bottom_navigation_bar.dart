import 'package:dotd/config/app_colors.dart';
import 'package:flutter/material.dart';

Widget bottomNavigationBar (context){
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.receipt),
        label: 'Draw the meal',
      ),
    ],
    currentIndex: 0,
    selectedItemColor: AppColors.primaryColor,
  );
}
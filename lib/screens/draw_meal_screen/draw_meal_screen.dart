import 'package:flutter/material.dart';

class DrawMealScreen extends StatelessWidget {
  const DrawMealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Draw meal!'),
      ),
      body: SafeArea(child: _body(context)),
    );
  }

  Widget _body(context) {
    return Center(
      child: const Text('Here you will draw random idea for dinner :)'),
    );
  }

}
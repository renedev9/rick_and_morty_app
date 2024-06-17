import 'package:flutter/material.dart';

class RickLoadingPage extends StatelessWidget {
  const RickLoadingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image(image: AssetImage('assets/tenor.gif'),fit: BoxFit.cover,))),
    );
  }
}
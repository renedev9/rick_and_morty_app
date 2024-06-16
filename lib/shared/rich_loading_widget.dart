import 'package:flutter/material.dart';

class RickLoadingPage extends StatelessWidget {
  const RickLoadingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Image(image: AssetImage('assets/tenor.gif'),fit: BoxFit.cover,)),
    );
  }
}
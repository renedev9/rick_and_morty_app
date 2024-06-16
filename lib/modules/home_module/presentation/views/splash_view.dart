import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'views_export.dart';


class SplashView extends StatefulWidget {
  static const String name='splash';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
     _cargarGift(context);
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.black45,
      extendBody: true,
      body: Center(child: Image.asset('assets/splash_light.jpg',fit: BoxFit.cover,)),//_cargarGift(context),
    );
  }
}
 _cargarGift(BuildContext context){
   // Timer(Duration(milliseconds: 3000), ()=> Image.asset('assets/vomito.gif'));
   // context.go(HomeView.name);
   Future.delayed(const Duration(milliseconds: 3000),()=>context.goNamed(HomeView.name));
  }
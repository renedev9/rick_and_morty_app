import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/models_export.dart';

class CharacterListTite extends StatelessWidget {
  const CharacterListTite({
    super.key,
    // required this.lista,
    required this.character,
  });

  // final List<CharacterModel> lista;
  final CharacterModel character;
  

  @override
  Widget build(BuildContext context) {
    log(character.image);
    Size size = MediaQuery.of(context).size;
    Color colorByStatus=character.status.name=='DEAD'?Colors.red.shade300: character.status.name!='ALIVE'?Colors.grey:Colors.green.shade300;
    return Hero(
      tag: character.id,
      transitionOnUserGestures: true,
      child: GestureDetector(
        onTap: (){
          context.pushNamed('details',pathParameters: {
            'detail':json.encode(character),
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: colorByStatus,width: 3)),borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                onError:(exception, stackTrace) => AssetImage('assets/no_image.jpg'),
                  image: NetworkImage(character.image), fit: BoxFit.cover)),
          constraints: BoxConstraints(maxWidth: size.width / 2,maxHeight: size.height / 5,minWidth: size.width / 2,minHeight:  size.height / 5),
          height: size.height / 5,
          width: size.width / 2,
          child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.transparent, Colors.white])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                  Text(
                    character.name.toUpperCase(),
                    textScaler: TextScaler.noScaling,
                    style:  TextStyle(fontWeight: FontWeight.bold,fontSize: size.width/20),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                         
                          color: colorByStatus,//character.status.name=='DEAD'?Colors.red: character.status.name!='ALIVE'?Colors.grey:Colors.green,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                      children: [
                    TextSpan(text: '${character.status.name.toUpperCase()}  '),
                    TextSpan(text: character.species.name.toUpperCase()),
                  ]))
                 ,
                ],
              )),
        ),
      ),
    );
  }
}

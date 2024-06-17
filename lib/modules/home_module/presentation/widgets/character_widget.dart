import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/modules/home_module/presentation/views/details_view.dart';
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
    
    final ColorScheme colors = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    Color colorByStatus=character.status.name=='DEAD'?Colors.red.shade300: character.status.name!='ALIVE'?Colors.grey:Colors.green.shade300;
        Color colorByStatusText=character.status.name=='DEAD'?Colors.red: character.status.name!='ALIVE'?Colors.grey:Colors.green;

    return Hero(
      tag: character.id,
      transitionOnUserGestures: true,
      child: GestureDetector(
        onTap: (){
          context.pushNamed(DetailsView.name,pathParameters: {
            'detail':json.encode(character),
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: colorByStatus,width: 3)),borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                onError:(exception, stackTrace) => const AssetImage('assets/no_image.jpg'),
                  image: CachedNetworkImageProvider(character.image),
                  //NetworkImage(character.image), 
                  fit: BoxFit.cover)
                  ),
          constraints: BoxConstraints(maxWidth: size.width / 2,maxHeight: size.height / 5,minWidth: size.width / 2,minHeight:  size.height / 5),
          height: size.height / 5,
          width: size.width / 2,
          child: Container(
              alignment: Alignment.bottomCenter,
              decoration:  BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.transparent, colors.primary])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                  Text(
                    character.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    textScaler: TextScaler.noScaling,
                    style:  TextStyle(fontWeight: FontWeight.bold,fontSize: size.width/20),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                         
                          color: colorByStatusText,//character.status.name=='DEAD'?Colors.red: character.status.name!='ALIVE'?Colors.grey:Colors.green,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                      children: [
                     TextSpan(text: 'Status : ',style: TextStyle(color: colors.secondary)),
                    TextSpan(text: '${character.status.name.toUpperCase()}  '),
                     TextSpan(text: 'Species : ',style: TextStyle(color: colors.secondary)),
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

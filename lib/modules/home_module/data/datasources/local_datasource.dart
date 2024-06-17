import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/models/models_export.dart';

abstract class LocalDataSource{
  Future<void> setCharacterList(int page,List<dynamic> list);
  Future<Map<String,dynamic>> getCharacterList();
  Future<Map<String,dynamic>> addCharacterList(int page,List<dynamic> listCharacter);
}

class LocalDataSourceImpl implements LocalDataSource{
  final FlutterSecureStorage storage=const FlutterSecureStorage();
  
  //* Este método acualiza la lista de characters y la pagina
  @override
  Future<void> setCharacterList(int page,List<dynamic> list) async{
try {
  Map<String,dynamic> map={'page':page,'characters':list};
  await storage.write(key: 'CharactersMap', value: json.encode(map));//.whenComplete(() => log('Se ha actualizado el mapa de characters ==> $map'));
} catch (e) {
  throw Exception(e);
 }
}
  //* Este método es para obtener la lista de characters
  @override
  Future<Map<String,dynamic>> getCharacterList() async{
    //! Aqui esta reventando , verificar que se pase la lista de CharacterModel vacia, para ello crear el metodo empty en clase CharacterModel
    List<dynamic> list =[];
    int page=0;
    Map<String,dynamic> initialMap={'page':page,'characters':json.encode(list)};
    try {
      if(!await storage.containsKey(key: 'CharactersMap')){
        return initialMap;
      }else{

     final  characterMap = await storage.read(key: 'CharactersMap');
     Map<String,dynamic> map=json.decode(characterMap!);
    
    /*  for (var i = 0; i < listAux.length; i++) {
       CharacterModel auxCharacter= CharacterModel.fromJson(listAux[i]);
       list.add(auxCharacter);
     } */
     log('Así queda la lista ==> $list');
     //list.addAll();
     list=map['characters'];
     page=map['page'];
      }
      Map<String,dynamic> mapResponse={'page':page,'characters':json.encode(list)};
     return mapResponse;
    } catch (e) {
      throw Exception(e);
    }
  }
  //* Este método adiciona a la lista de characters existente una nueva lista y actualiza la pagina existente, luego retorna el mapa actualizado
  @override
  Future<Map<String,dynamic>> addCharacterList(int page,List<dynamic> listCharacter) async{
  Map<String,dynamic> map=  await getCharacterList();
  List<dynamic>list=json.decode(map['characters']);
  // list.add(listCharacter.where((element) => element!=list));
  list.addAll(listCharacter);
  Map<String,dynamic>mapUpdated= {'page':page,'characters':json.encode(list)};
  setCharacterList(page, list);
  return mapUpdated;
  }
}
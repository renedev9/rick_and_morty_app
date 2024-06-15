import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/core/constants/constants.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/models/models_export.dart';

abstract class RemoteDataSource{
  Future<Either<Failure,ListCharacterModel>> getCharacters(int page);
  Future<Either<Failure,ListCharacterModel>>filterCharacters(Map<String,dynamic> mapToFilter);
}

class RemoteDataSourceImpl implements RemoteDataSource{
  @override
  Future<Either<Failure, ListCharacterModel>> getCharacters(page) async{
    
    try {
    final response= await http.get(Uri.parse('${Constants.characterEndpoint}/?page=$page'));
    if(response.statusCode==200){
      if(response.body is Map){
        log(response.body);
        return Right( ListCharacterModel.fromJson(json.decode(response.body)));
      }else{

      log(response.body);
      return Right( ListCharacterModel.fromJson(json.decode(response.body)));
      }
    }else{
      return Left(ServerFailure(errorMessage: 'Error del servidor'));
    }
    } catch (e) {
    throw Exception(e);  
    }
  }
  
  @override
  Future<Either<Failure, ListCharacterModel>> filterCharacters(Map<String, dynamic> mapToFilter) async{
    String name=mapToFilter['name']??'';
    String status=mapToFilter['status']??'';
    String species=mapToFilter['species']??'';
    String type=mapToFilter['type']??'';
    String gender=mapToFilter['gender']??'';
    int page=mapToFilter['page']??0;
    try {
    final response= await http.get(Uri.parse('${Constants.characterEndpoint}/?name=$name&status=$status&species=$species&type=$type&gender=$gender&page=$page'));
    if(response.statusCode==200){
      if(response.body is Map){
        log(response.body);
        return Right( ListCharacterModel.fromJson(json.decode(response.body)));
      }else{

      log(response.body);
      return Right( ListCharacterModel.fromJson(json.decode(response.body)));
      }
    }else{
      return Left(ServerFailure(errorMessage: 'Error del servidor'));
    }
    } catch (e) {
    throw Exception(e);  
    }
  }
}
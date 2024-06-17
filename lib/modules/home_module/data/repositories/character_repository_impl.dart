import 'package:dartz/dartz.dart';

import 'package:rick_and_morty_app/core/errors/failure.dart';

import '../datasources/datasource_export.dart';
import '../../domain/models/models_export.dart';
import '../../domain/repository/reposity_export.dart';

class CharacterRepositoryImpl implements RemoteCharacterRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  CharacterRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, ListCharacterModel>> getCharacters(int page) async{
   try {
   final response= await remoteDataSource.getCharacters(page);  	
  return response.fold((l) => Left(l), (r) => Right(r));
   } catch (e) {
     rethrow;
   }
 }
 
  @override
  Future<Either<Failure, ListCharacterModel>> filterCharacters(Map<String,dynamic> mapToFilter) async{
    try {
      final response= await remoteDataSource.filterCharacters(mapToFilter);
      return response.fold((l) => Left(l), (r) =>Right(r));
    } catch (e) {
       rethrow;
    }
  }
 
  
}

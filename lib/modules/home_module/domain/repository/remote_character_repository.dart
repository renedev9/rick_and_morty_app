
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/models_export.dart';

abstract class RemoteCharacterRepository{
  
  Future<Either<Failure,ListCharacterModel>> getCharacters(int page);
  Future<Either<Failure,ListCharacterModel>>filterCharacters(Map<String,dynamic> mapToFilter);

}
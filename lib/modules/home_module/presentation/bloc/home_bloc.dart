import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/modules/home_module/data/datasources/local_datasource.dart';
import 'package:rick_and_morty_app/modules/home_module/data/datasources/remote_datasoure.dart';
import 'package:rick_and_morty_app/modules/home_module/domain/models/characters_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../conectivity_module/conectivity_export.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LocalDataSource localDataSource = LocalDataSourceImpl();
  final RemoteDataSource remoteDataSource = RemoteDataSourceImpl();
  final ConectivityBloc conectivityBloc;
  HomeBloc(this.conectivityBloc) : super(HomeStandardState.empty()) {
    //* Escucha de evento para cargar personajes
    on<LoadCharactersEvent>(_loadCharactersEvent);
    //* Escucha de evento para filtrar personajes
    on<FilterCharactersEvent>(_filterCharactersEvent);
    //* Escucha de evento para limpiar filtrado de personajes
    on<ClearCharactersEvent>(_clearCharactersEvent);
    //* Escucha de evento para manejar el estado de la conexión en el módulo de home
    on<ConnectionStateEvent>(_connectionStateEvent);
    init();
  }

  //* Aquí se disparan eventos iniciales del bloc y se maneja logica para conectividad
  void init() {
   conectivityBloc.stream.listen((state) {
    if(state is ConnectivityDisconnected){
      add(const ConnectionStateEvent(connectionState: 'Disconnected'));
    }
    if(state is ConnectivityConnected){
       add(const ConnectionStateEvent(connectionState: 'Connected'));
    }
    //TODO: Aqui ir agregando todos los estados de conectividad que se desee manejar
    });
   }

  //* Evento para manejar la carga del listado de personajes
  void _loadCharactersEvent(
      LoadCharactersEvent event, Emitter<HomeState> emit) async {
    int pageToSend = 0; //* variable para controlar las paginas
    //* Proceso de carga de la petición
    emit((state as HomeStandardState).copyWith(loading: true));

    final localCharacters = await localDataSource
        .getCharacterList(); //* Lista local de personajes guardados

    //* Aqui garantizamos que siempre que este vacía la lista guardada, se garantice realizar la petición
    if (json.decode(localCharacters['characters']).isEmpty ||
        (json.decode(localCharacters['characters']).isNotEmpty &&
            event.activePagination == true)) {
      pageToSend = localCharacters['page'];
      pageToSend++;

      /* if(localCharacters.info!=null && localCharacters.info!.next.contains('page=')){
    pageToSend= int.parse(checkElements(localCharacters.info!.next));
   } */

      try {
        Map<String, dynamic> mapData = {};
        final characters = await remoteDataSource.getCharacters(pageToSend);
        await characters.fold((l) {
          emit((state as HomeStandardState)
              .copyWith(loading: false, failure: l));
        }, (r) async {
          //* Se actualiza la lista local con la nueva y se emite el state con la lista actualizada
          mapData =
              await localDataSource.addCharacterList(pageToSend, r.results);
        });

        emit((state as HomeStandardState).copyWith(
            failure: null,
            loading: false,
            pages: null,
            characterList: ListCharacterModel(
                results: List<CharacterModel>.from(json
                    .decode(mapData['characters'])
                    .map((x) => CharacterModel.fromJson(x)))),
            currentPaginate:
                null, //event.initialPaginate==true?pagination:pagination+1,
            currentParamsToFilter: null));
      } catch (e) {
        throw Exception(e);
      }
    } else if (json.decode(localCharacters['characters']).isNotEmpty &&
        event.activePagination == false) {
      emit((state as HomeStandardState).copyWith(
        loading: false,
        characterList: ListCharacterModel(
            results: List<CharacterModel>.from(json
                .decode(localCharacters['characters'])
                .map((x) => CharacterModel.fromJson(x)))),
        // page: localCharacters['page']
      ));
    }
  }

  //* Evento para filtrar personajes y mantener la paginación
  void _filterCharactersEvent(
      FilterCharactersEvent event, Emitter<HomeState> emit) async {
    emit((state as HomeStandardState).copyWith(
        loading: true,
        activeFilter: true,
        currentPaginate: event.initialPaginate == true ? 1 : null));
    int pagination = 1;
    Map<String, dynamic> mapDataToSend = {
      'name': '',
      'status': '',
      'species': '',
      'type': '',
      'gender': '',
      'page': 0
    };
    if (event.initialPaginate == false) {
      pagination = (state as HomeStandardState).currentPaginate + 1;
      mapDataToSend = {
        'name': (state as HomeStandardState).currentParamsToFilter!['name'],
        'status': (state as HomeStandardState).currentParamsToFilter!['status'],
        'species':
            (state as HomeStandardState).currentParamsToFilter!['species'],
        'type': (state as HomeStandardState).currentParamsToFilter!['type'],
        'gender': (state as HomeStandardState).currentParamsToFilter!['gender'],
        'page': (state as HomeStandardState).currentPaginate + 1,
      };
    } else {
      mapDataToSend = {
        'name': event.name,
        'status': event.status,
        'species': event.species,
        'type': event.type,
        'gender': event.gender,
        'page': pagination
      };
    }

    if (pagination <= (state as HomeStandardState).pages) {
      try {
        final characters =
            await remoteDataSource.filterCharacters(mapDataToSend);
        characters.fold((l) {
          emit((state as HomeStandardState).copyWith(
            loading: false,
            failure: l,
          ));
        }, (r) {
          //int currentPaginate=1;
          emit((state as HomeStandardState).copyWith(
              loading: false,
              characterList: r,
              pages: r.info!.pages,
              currentPaginate:
                  pagination, //event.initialPaginate==true?pagination:pagination+1,
              currentParamsToFilter: mapDataToSend));
        });
      } catch (e) {
        throw Exception(e);
      }
    } else {
      emit((state as HomeStandardState).copyWith(
        loading: false,
        activeFilter: false,
        currentPaginate: pagination,
      ));
    }
  }

//* Evento para eliminar filtros
  void _clearCharactersEvent(
      ClearCharactersEvent event, Emitter<HomeState> emit) {
    if (event.clearEvent == true) {
      emit(HomeStandardState.empty());
    }
  }
//* Evento para manejar la conexión del dispositivo en el módulo home
  void _connectionStateEvent(
      ConnectionStateEvent event, Emitter<HomeState> emit) {
    if (event.connectionState == 'Disconnected') {
      emit((state as HomeStandardState).copyWith(
        connectionState: ConectivityValue.Disconnected
      ));
    }
    if (event.connectionState == 'Connected') {
       emit((state as HomeStandardState).copyWith(
        connectionState: ConectivityValue.Connected
      ));
    }
  }
}

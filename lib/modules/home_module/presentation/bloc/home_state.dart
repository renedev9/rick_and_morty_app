part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeStandardState extends HomeState {
  //* Control de la conectividad de la aplicacion ,dentro del modulo home
  final ConectivityValue? connectionState;
  //* Control de estado de carga de la peticion
  final bool loading;
  //* Failure el cual tiene el mensaje de error de cada peticion
  final Failure? failure;
  //* Control del listados de personajes
  final ListCharacterModel characterList;
  //* Control del total de paginas que se este trabajando en el filtro
  final int pages;
  //* Pagina actual del filtro o listado de personajes
  final int currentPaginate;
  //* Chequea cuando este activo el filtro
  final bool? activeFilter; 
  //*Parametros a filtrar, para controlar elementos actuales de filtro en caso de perder conexion, ya que estos elementos filtrados no se almacenan localmente
  final Map<String,dynamic>? currentParamsToFilter;
  const HomeStandardState(  
      {required this.loading,
       this.failure,
       this.activeFilter=false, 
      required this.characterList,
      required this.pages,
      required this.currentPaginate,
      this.currentParamsToFilter,
      this.connectionState=ConectivityValue.Connected,
      });

  HomeStandardState copyWith({ loading,  failure,
       characterList,  pages,activeFilter,currentPaginate,currentParamsToFilter,connectionState}) {
    return HomeStandardState(
        loading: loading??this.loading,
        failure: failure??this.failure,
        characterList: characterList??this.characterList,
        pages: pages??this.pages,
        activeFilter:activeFilter??this.activeFilter,
         currentPaginate: currentPaginate??this.currentPaginate,
         currentParamsToFilter:currentParamsToFilter??this.currentParamsToFilter,
         connectionState:connectionState??this.connectionState
        );
  }

  factory HomeStandardState.empty() {
    return HomeStandardState(
        loading: false,
        characterList: ListCharacterModel(results: <CharacterModel>[]),
        failure: ServerFailure(errorMessage: ''),
        pages: 1,
        activeFilter: false, 
        currentPaginate: 1,
        currentParamsToFilter:const{},
        connectionState:ConectivityValue.Connected
        );
  }
  @override
  List<Object> get props => [
    loading,
    characterList,
    failure!,
    pages,
   activeFilter!,
   currentPaginate,
   currentParamsToFilter!,
   connectionState!
  ];
}

enum ConectivityValue{
 Connected,
 Disconnected
}


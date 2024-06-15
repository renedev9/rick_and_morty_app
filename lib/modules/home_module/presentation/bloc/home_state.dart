part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeStandardState extends HomeState {
  final ConectivityValue? connectionState;
  final bool loading;
  final Failure? failure;
  final ListCharacterModel characterList;
  final int pages;
  final int currentPaginate;
  final bool? activeFilter;
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


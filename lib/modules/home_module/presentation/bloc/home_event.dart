part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadCharactersEvent extends HomeEvent {
  final bool? activePagination;
  const LoadCharactersEvent({this.activePagination = false});
}

class FilterCharactersEvent extends HomeEvent {
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final bool? initialPaginate ;
  const FilterCharactersEvent(
      {this.name='', this.gender='', this.species='', this.status='', this.type='',this.initialPaginate = false});
}

class ClearCharactersEvent extends HomeEvent{
  final bool clearEvent;
  const ClearCharactersEvent({required this.clearEvent, });
}

class ConnectionStateEvent extends HomeEvent{
  final String connectionState;
  const ConnectionStateEvent({required this.connectionState, });
}

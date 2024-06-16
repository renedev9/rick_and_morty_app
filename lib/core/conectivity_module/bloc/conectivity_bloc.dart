import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart' as connectivity;

part 'conectivity_event.dart';
part 'conectivity_state.dart';



class ConectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  
  ConectivityBloc() : super(ConnectivityInitial()) {

    connectivity.Connectivity().onConnectivityChanged.listen((event) {
        for (var i = 0; i < event.length; i++) {
          
      if (event[i] == connectivity.ConnectivityResult.none) {
        add(const ConnectivityChanged(false));
      } else {
        add(const ConnectivityChanged(true));
      }
        }
   
      });

    on<ConnectivityChanged>((event, emit) {
        if (event.isConnected) {
        emit(ConnectivityConnected());
       } else {
        emit(ConnectivityDisconnected());
        }
    
    
    });
  }
}
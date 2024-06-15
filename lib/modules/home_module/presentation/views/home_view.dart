import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/modules/conectivity_module/presentation/bloc/conectivity_bloc.dart';
import 'package:rick_and_morty_app/modules/home_module/presentation/bloc/home_bloc.dart';

import '../../domain/models/models_export.dart';
import '../widgets/widgets_export.dart';

class HomeView extends StatefulWidget {
  static const String name = 'home';
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();//* Control de scroll

  bool bottomScroll =false; //* Bandera para dibujar Progress Indicator al final del scroll

  bool activeFilterScroll =false; //*Filtro para controlar el cambio de la pagina

  bool cancelScroll =false; //* bandera para cancelar el scroll en caso de que se pierda la conexion o llegue al final del paginado
  
  List<CharacterModel> characters = [];//* Control de listado de personajes
  
  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(const LoadCharactersEvent());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (cancelScroll == false) {
          setState(() {
            bottomScroll = true;
          });
          if (activeFilterScroll) {
            context
                .read<HomeBloc>()
                .add(const FilterCharactersEvent(initialPaginate: false));
            
          } else if (bottomScroll == true) {
            context
                .read<HomeBloc>()
                .add(const LoadCharactersEvent(activePagination: true));
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final blocConectivity = context.watch<ConectivityBloc>();
    /*  if(stateConect.state is ConnectivityConnected){
    ScaffoldMessenger.of(context).clearSnackBars();
  }
  if(stateConect.state is ConnectivityDisconnected){
    final snackBar = SnackBar(
              content: Text(
                  'Se ha perdido la conexion, se trabajara con datos locales'),
              duration: Duration(milliseconds: 2000),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            context.read<HomeBloc>().add(const LoadCharactersEvent());
  } */
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeStandardState) {
           if(state.connectionState==ConectivityValue.Disconnected){
            setState(() {
              cancelScroll=true;
            });
           const snackbar=SnackBar(content: Text('You lost connection, crazy human'),duration: Duration(milliseconds: 2000),);
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
          if(state.connectionState==ConectivityValue.Connected){
            if(cancelScroll==true){

             setState(() {
              cancelScroll=false;
               const snackbar=SnackBar(content: Text('Morty came back, he came back'),duration: Duration(milliseconds: 2000),);
               ScaffoldMessenger.of(context).showSnackBar(snackbar);
            });
            }
          }
          /* if (state.connectionState == 'Disconnected') {
            setState(() {
              bottomScroll = false;
              activeFilterScroll = false;
              cancelScroll = false;
            });
            final snackBar = SnackBar(
              content: Text(
                  'Se ha perdido la conexion, se trabajara con datos locales'),
              duration: Duration(milliseconds: 2000),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            context.read<HomeBloc>().add(const LoadCharactersEvent());
          }
          if (state.connectionState == 'Connected') {
            setState(() {
              bottomScroll = false;
              activeFilterScroll = false;
              cancelScroll = false;
            });
            final snackBar = SnackBar(
              content: Text(
                  'Se ha perdido la conexion, se trabajara con datos locales'),
              duration: Duration(milliseconds: 2000),
            );
            ScaffoldMessenger.of(context).clearSnackBars();
           
          } */
          /* setState(() {
            activeFilterScroll=state.activeFilter!;
          }); */
          /* if(state.loading==false && state.characterList.results.isNotEmpty){
         setState(() {
           lista=state.characterList.results;
         });
        }  */
          if (bottomScroll == true && state.loading == false) {
            _scrollController.animateTo(_scrollController.position.pixels + 100,
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 250));
            setState(() {
              bottomScroll = false;
            });
          }
          if (state.currentPaginate > state.pages && cancelScroll == false) {
            setState(() {
              activeFilterScroll = false;
              bottomScroll = false;
              cancelScroll = true;
            });
          }
         
          /* 
        
          if(state.currentPaginate>state.pages){
            setState(() {
              bottomScroll=false;
              activeFilterScroll=false;
            });
          } */
        }
      },
      builder: (context, state) {
        if (state is HomeStandardState && (state.connectionState==ConectivityValue.Disconnected)) {
          if(state.characterList.results.isNotEmpty){
            characters=state.characterList.results;
          return Scaffold(
            body: SafeArea(
              child: Stack(children: [
                Padding(
                  padding:
                      EdgeInsets.only(bottom: bottomScroll == false ? 0 : 40),
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
                        CharacterModel character = characters[index];
                        return CharacterListTite(character: character);
                      }),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _cargarData(),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ]),
            ),
          );
          }else{
            return const Scaffold(body: Center(child:Text('You lost connection, crazy human',textAlign: TextAlign.center,)),);
          }
        }
        if (state is HomeStandardState &&
            state.loading &&
            bottomScroll == false) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is HomeStandardState && state.characterList.results.isEmpty) {
          return const Scaffold(
              body: Center(
            child: Text('No hay personajes'),
          ) /* ,floatingActionButton: FloatingActionButton(onPressed: (){
              context.read<HomeBloc>().add(const LoadCharactersEvent(activeFilter: true));
            },), */
              );
        } else if (state is HomeStandardState) {
          if (state.currentPaginate > 1 &&
              state.loading == false &&
              (state.currentPaginate <= state.pages)) {
            characters.addAll(state.characterList.results);
          } else if (state.currentPaginate <= 1 &&
              state.loading == false &&
              (state.currentPaginate <= state.pages)) {
            characters = state.characterList.results;
          }
          return Scaffold(
            body: SafeArea(
              child: Stack(children: [
                Padding(
                  padding:
                      EdgeInsets.only(bottom: bottomScroll == false ? 0 : 40),
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
                        CharacterModel character = characters[index];
                        return CharacterListTite(character: character);
                      }),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _cargarData(),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ]),
            ),
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.filter_alt_outlined),
                onPressed: () {
                  //log('Se va a filtrar la pagina ==> $pageToPaginate');
                  setState(() {
                    activeFilterScroll = true;
                  });
                  showDialog(
                    context: context,
                    builder: (context) {
                      return FilterAlertDialog(
                        dialogContext: context,
                        clearFunction: () {
                          context.pop();
                          context.read<HomeBloc>().add(
                              const ClearCharactersEvent(clearEvent: true));
                          context
                              .read<HomeBloc>()
                              .add(const LoadCharactersEvent());
                          setState(() {
                            cancelScroll = false;
                            activeFilterScroll = false;
                          });
                        },
                      );
                    },
                  );
                  //context.read<HomeBloc>().add(FilterCharactersEvent(name: 'Rick',status: 'alive'));
                }),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _cargarData() {
    if (bottomScroll == true) {
      return const CircularProgressIndicator();
    }
    return Container();
  }
}

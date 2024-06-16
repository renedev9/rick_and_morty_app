import 'dart:convert';

import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/modules/home_module/domain/models/characters_model.dart';

import '../../modules/home_module/presentation/views/views_export.dart';

final appRouter= GoRouter(
  initialLocation: '/splash',
  routes: [
GoRoute(
  path: '/home',
  name:HomeView.name,
  builder: (context, state) {
    return const HomeView();
  },
  ),
GoRoute(
  path: '/splash',
  name: SplashView.name,
  builder: (context, state) {
    return const SplashView();
  },
  ),
GoRoute(
  path: '/details/:detail',
  name: DetailsView.name,
  builder: (context, state) {
    CharacterModel characterModel=CharacterModel.fromJson(json.decode( state.pathParameters['detail']!));
    return  DetailsView(character: characterModel);
  },
  ),

  GoRoute(
  path: '/',
  redirect: (_, __){
    return '/home';
  },
  ),

],
);
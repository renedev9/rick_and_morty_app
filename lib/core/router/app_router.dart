import 'package:go_router/go_router.dart';

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
    return  DetailsView(detail: state.pathParameters['details']);
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
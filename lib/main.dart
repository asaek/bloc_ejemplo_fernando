import 'package:blocs_app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'presentation/blocs/blocs.dart';
import 'presentation/blocs/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsernameCubit>(
          create: (BuildContext context) => getIt<UsernameCubit>(),
          lazy: false,
        ),
        BlocProvider<RouterSimpleCubit>(
            create: (BuildContext context) => getIt<RouterSimpleCubit>()),
        BlocProvider<CounterCubit>(create: (context) => getIt<CounterCubit>()),
        BlocProvider<ThemeCubit>(create: (context) => getIt<ThemeCubit>()),
        BlocProvider<GuestsBloc>(create: (context) => getIt<GuestsBloc>()),
        BlocProvider<PokemonBloc>(create: (context) => getIt<PokemonBloc>()),
        BlocProvider<GeolocationCubit>(
            create: (context) => getIt<GeolocationCubit>()),
        BlocProvider<HistoricLocationBloc>(
            create: (context) => getIt<HistoricLocationBloc>()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter appRouter = context.watch<RouterSimpleCubit>().state;
    return MaterialApp.router(
      title: 'Flutter BLoC',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme(isDarkmode: context.watch<ThemeCubit>().state.isDarkmode)
          .getTheme(),
    );
  }
}

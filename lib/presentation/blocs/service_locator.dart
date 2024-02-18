import 'package:blocs_app/presentation/blocs/blocs.dart';
import 'package:get_it/get_it.dart';

import '../../config/config.dart';

GetIt getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<ThemeCubit>(ThemeCubit());
  getIt.registerSingleton<CounterCubit>(CounterCubit());
  getIt.registerSingleton<UsernameCubit>(UsernameCubit());
  getIt.registerSingleton<RouterSimpleCubit>(RouterSimpleCubit());
  getIt.registerSingleton<GuestsBloc>(GuestsBloc());

  getIt.registerSingleton<PokemonBloc>(
      PokemonBloc(pokemonTypeDef: PokemonInformation.getPokemonName));

  getIt.registerSingleton<HistoricLocationBloc>(HistoricLocationBloc());
  getIt.registerSingleton<GeolocationCubit>(GeolocationCubit(
      onNewUserLocation: getIt<HistoricLocationBloc>().onNewUserLocation)
    ..watchuserLocation());
}

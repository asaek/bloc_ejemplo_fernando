import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

typedef PokemonTypeDef = Future<String> Function(int id);

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonTypeDef _pokemonTypeDef;

  PokemonBloc({required PokemonTypeDef pokemonTypeDef})
      : _pokemonTypeDef = pokemonTypeDef,
        super(const PokemonState()) {
    on<PokemonAdded>((event, emit) {
      final newPokemon = Map<int, String>.from(state.pokemons);
      newPokemon[event.id] = event.name;
      emit(state.copyWith(pokemons: newPokemon));
    });
  }

  Future<String> fetchPokemonName(int id) async {
    // para utilizar la cache
    if (state.pokemons.containsKey(id)) {
      return state.pokemons[id]!;
    }

    try {
      final pkemonName = await _pokemonTypeDef(id);
      add(PokemonAdded(id, pkemonName));

      return pkemonName;
    } catch (e) {
      throw Exception('Pokemon $id not found');
    }
  }
}

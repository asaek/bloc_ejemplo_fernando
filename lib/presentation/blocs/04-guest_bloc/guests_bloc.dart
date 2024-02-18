import 'package:bloc/bloc.dart';
import 'package:blocs_app/config/config.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/domain.dart';

part 'guests_event.dart';
part 'guests_state.dart';

const uuid = Uuid();

class GuestsBloc extends Bloc<GuestsEvent, GuestsState> {
  GuestsBloc()
      : super(GuestsState(
          guests: [
            Todo(
              id: uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: null,
            ),
            Todo(
              id: uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: null,
            ),
            Todo(
              id: uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: DateTime.now(),
            ),
            Todo(
              id: uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: DateTime.now(),
            ),
            Todo(
              id: uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: null,
            ),
          ],
        )) {
    on<SetCustomFilterEvent>((event, emit) {
      emit(state.copyWith(filter: event.newFilter));
    });

    on<AddGuestEvent>(_addGuesHandler);
    on<ToggleGuestEvent>(_toggleGuestHandler);

    // on<SetInvitedFilterEvent>((event, emit) {
    //   emit(state.copyWith(filter: GuestsFilter.invited));
    // });

    // on<SetNoInvitedFilterEvent>((event, emit) {
    //   emit(state.copyWith(filter: GuestsFilter.noInvited));
    // });

    // on<SetAllFilterEvent>((event, emit) {
    //   emit(state.copyWith(filter: GuestsFilter.all));
    // });
  }
  void toggleGuest(String id) {
    add(ToggleGuestEvent(id));
  }

  void changeFilter(GuestsFilter filter) {
    add(SetCustomFilterEvent(filter));
    // switch (filter) {
    //   case GuestsFilter.all:
    //     add(SetAllFilterEvent());
    //     break;
    //   case GuestsFilter.invited:
    //     add(SetInvitedFilterEvent());
    //     break;
    //   case GuestsFilter.noInvited:
    //     add(SetNoInvitedFilterEvent());
    //     break;
    // }
  }

  void addGuest(String nombre) {
    add(AddGuestEvent(nombre));
  }

  void _addGuesHandler(AddGuestEvent event, Emitter<GuestsState> emit) {
    final newGuest = Todo(
      id: uuid.v4(),
      description: event.nombre,
      completedAt: null,
    );
    emit(state.copyWith(guests: [...state.guests, newGuest]));
  }

  void _toggleGuestHandler(ToggleGuestEvent event, Emitter<GuestsState> emit) {
    final newGuests = state.guests.map((guest) {
      if (guest.id == event.id) {
        return guest.copyWith(
          completedAt: guest.completedAt == null ? DateTime.now() : null,
        );
      }
      return guest;
    }).toList();
    emit(state.copyWith(guests: newGuests));
  }
}

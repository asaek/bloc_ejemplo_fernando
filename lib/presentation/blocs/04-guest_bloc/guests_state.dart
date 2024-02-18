part of 'guests_bloc.dart';

enum GuestsFilter {
  all,
  invited,
  noInvited,
}

class GuestsState extends Equatable {
  final GuestsFilter filter;
  final List<Todo> guests;
  const GuestsState({
    this.filter = GuestsFilter.all,
    this.guests = const [],
  });

  int get howManyGuests => guests.length;

  List<Todo> get filteredGuests {
    switch (filter) {
      case GuestsFilter.invited:
        return guests.where((guest) => guest.done).toList();
      case GuestsFilter.noInvited:
        return guests.where((guest) => !guest.done).toList();
      case GuestsFilter.all:
        return guests;

      default:
        throw Exception('Unknown filter: $filter');
    }
  }

  int get howManyInvited => filteredGuests.length;

  GuestsState copyWith({
    GuestsFilter? filter,
    List<Todo>? guests,
  }) =>
      GuestsState(
        filter: filter ?? this.filter,
        guests: guests ?? this.guests,
      );

  @override
  List<Object> get props => [filter, guests];
}

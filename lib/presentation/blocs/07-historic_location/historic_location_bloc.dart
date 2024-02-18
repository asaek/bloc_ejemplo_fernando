import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'historic_location_event.dart';
part 'historic_location_state.dart';

class HistoricLocationBloc
    extends Bloc<HistoricLocationEvent, HistoricLocationState> {
  HistoricLocationBloc() : super(const HistoricLocationState()) {
    //* tambien se puede enviar asi como lo comentado bien tipado
    // on((NewLocation event, emit) => _onNewLocation(event, emit));
    on(_onNewLocation);
  }

  void onNewUserLocation((double lat, double long) location) {
    add(NewLocation(location));

    print(location);
  }

  void _onNewLocation(NewLocation event, Emitter<HistoricLocationState> emit) {
    emit(state.copyWith(
      locations: [...state.locations, event.location],
    ));
  }
}

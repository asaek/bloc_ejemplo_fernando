import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'geolocation_state.dart';

typedef OnNewUserLocationCallbak = void Function(
    (double lat, double long) location);

class GeolocationCubit extends Cubit<GeolocationState> {
  final OnNewUserLocationCallbak? onNewUserLocation;
  GeolocationCubit({this.onNewUserLocation}) : super(const GeolocationState());

  Future<void> checkStatus() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (serviceEnabled) {
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    } else {
      permission = await Geolocator.requestPermission();
    }

    emit(
      state.copyWith(
        serviceEnabled: serviceEnabled,
        permissionGranted: permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse,
      ),
    );
  }

  Future<void> watchuserLocation() async {
    await checkStatus();

    if (!state.serviceEnabled || !state.permissionGranted) return;

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 15,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        //Todo: Aqui ya sabemos la ubicacion del usuario
        final (double, double) newLocation =
            (position.latitude, position.longitude);

        emit(state.copyWith(location: newLocation));
        // * Si existe el callback, lo llamamos, es igual a lo comentado
        // if (onNewUserLocation != null) {
        //   onNewUserLocation!(newLocation);
        // }
        onNewUserLocation?.call(newLocation);
      },
    );
  }
}

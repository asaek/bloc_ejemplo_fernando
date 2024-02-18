import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';

class BlocsWithBlocsScreen extends StatelessWidget {
  const BlocsWithBlocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historicLocationBloc = context.watch<HistoricLocationBloc>();
    final locateState = historicLocationBloc.state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Conte de hubicaciones ${locateState.lengthLocations}'),
      ),
      body: ListView.builder(
        itemCount: locateState.lengthLocations,
        itemBuilder: (context, index) {
          final location = locateState.locations[index];
          final (lat, lng) = location;

          return ListTile(
            title: Text('Lat: $lat, Lng: $lng'),
          );
        },
      ),
    );
  }
}

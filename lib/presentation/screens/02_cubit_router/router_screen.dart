import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/config.dart';

class RouterScreen extends StatelessWidget {
  const RouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubit + Go Router'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          context.read<RouterSimpleCubit>().goBack();
        },
      ),
    );
  }
}

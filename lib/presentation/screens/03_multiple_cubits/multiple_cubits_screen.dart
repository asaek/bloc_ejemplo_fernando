import 'package:blocs_app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';

class MultipleCubitScreen extends StatelessWidget {
  const MultipleCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Cubits'),
      ),
      body: Center(
          child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          IconButton(
            // icon: const Icon( Icons.light_mode_outlined, size: 100 ),
            icon: Icon(
                (themeCubit.state.isDarkmode)
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                size: 100),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
          BlocBuilder<UsernameCubit, String>(
            builder: (context, state) {
              return Text(state, style: const TextStyle(fontSize: 25));
            },
          ),
          TextButton.icon(
            icon: const Icon(
              Icons.add,
              size: 50,
            ),
            label: BlocBuilder<CounterCubit, int>(
              builder: (context, state) => Text(
                "$state",
                style: const TextStyle(fontSize: 100),
              ),
            ),
            onPressed: () {
              context.read<CounterCubit>().incrementBy(1);
            },
          ),
          const Spacer(flex: 2),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nombre aleatorio'),
        icon: const Icon(Icons.refresh_rounded),
        onPressed: () {
          context
              .read<UsernameCubit>()
              .setUsername(RandomGenerator.getRandomName());
        },
      ),
    );
  }
}

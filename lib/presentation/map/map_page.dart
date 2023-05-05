import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_my_team/di/di.dart';
import 'package:where_my_team/domain/use_cases/team_usecases.dart';
import 'package:where_my_team/presentation/map/cubit/map_cubit.dart';
import 'cubit/team_map_cubit.dart';
import 'ui/map_screen.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeamMapCubit>(
          create: (_) => getIt<TeamMapCubit>(),
        ),
        BlocProvider<MapCubit>(
          create: (context) => MapCubit(
              homepageUseCases: getIt<TeamUsercase>(),
              userCubit: BlocProvider.of<TeamMapCubit>(context)),
        ),
      ],
      child: const MapScreen(),
    );
  }
}

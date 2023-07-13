import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/presentation/team/cubit/team_cubit.dart';
import 'package:wmteam/presentation/team/ui/team_screen.dart';

class TeamPage extends StatelessWidget {
  
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeamCubit>(
          create: (_) => getIt<TeamCubit>(),
        ),
      ],
      child: const TeamScreen(),
    );
  }
}

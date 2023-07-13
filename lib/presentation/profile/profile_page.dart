import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/di/di.dart';
import 'package:wmteam/presentation/profile/cubit/profile_cubit.dart';
import 'package:wmteam/presentation/profile/ui/profile_screen.dart';

class ProfilePage extends StatelessWidget {
  
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (_) => getIt<ProfileCubit>(),
        ),
      ],
      child: const ProfileScreen(),
    );
  }
}

import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmteam/common/widgets/m_route_overview.dart';
import 'package:wmteam/common/widgets/m_section.dart';
import 'package:wmteam/manifest.dart';
import 'package:wmteam/models/model_location.dart';
import 'package:wmteam/models/model_route.dart';
import 'package:wmteam/presentation/detail_route/detail_route_route.dart';
import 'package:wmteam/presentation/route/cubit/route_cubit.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(MultiLanguage.of(context).route),
        actions: [
          IconButton(onPressed: () => null, icon: Icon(Icons.analytics))
        ],
      ),
      body: FutureBuilder<bool>(
        future: context.read<RouteCubit>().loadRoutes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              final cubit = context.read<RouteCubit>();
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: cubit.state.routes.entries
                    .map((e) => MSection(
                        title: e.key,
                        headerColor: Theme.of(context).scaffoldBackgroundColor,
                        titleColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        content: Column(
                          children: e.value!
                              .map<Widget>((e) =>
                                  FutureBuilder<List<ModelLocation>?>(
                                      future: e.detailRouteEx,
                                      builder: (context, snapshot) => snapshot
                                              .hasData
                                          ? GestureDetector(
                                              onTap: () => XMDRouter.pushNamed(
                                                  routerIds[DetailRouteRoute]!,
                                                  arguments: {'route': e}),
                                              child: MRouteOverview(
                                                  coordinates: snapshot.data!
                                                      .map((e) => e.coordinate)
                                                      .toList(),
                                                  route: e),
                                            )
                                          : const LinearProgressIndicator()))
                              .toList(),
                        )).builder())
                    .toList(),
              );
            }
            return Center(child: Text(MultiLanguage.of(context).empty));
          }
          return const LinearProgressIndicator();
        },
      ),
    );
  }
}

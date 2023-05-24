import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:where_my_team/common/widgets/m_route_overview.dart';
import 'package:where_my_team/common/widgets/m_section.dart';
import 'package:where_my_team/manifest.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/models/model_route.dart';
import 'package:where_my_team/presentation/detail_route/detail_route_route.dart';
import 'package:where_my_team/presentation/route/cubit/route_cubit.dart';

class RouteScreen extends StatelessWidget {
  RouteScreen({super.key});

  final Map<String, Completer<GoogleMapController>> _controllers = {};

  int count = 0;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Route"),
        actions: [
          IconButton(onPressed: () => null, icon: Icon(Icons.analytics))
        ],
      ),
      body: FutureBuilder<bool>(
        future: context.read<RouteCubit>().loadRoutes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: context
                    .read<RouteCubit>()
                    .state
                    .routes
                    .entries
                    .map((e) => MSection(
                        title: e.key,
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
            return Center(child: Text("Empty"));
          }
          return const LinearProgressIndicator();
        },
      ),
    );
  }
}

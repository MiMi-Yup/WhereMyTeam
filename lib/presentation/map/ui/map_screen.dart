import 'dart:async';

import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/route/xmd_router.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:where_my_team/common/widgets/m_member_route_component.dart';
import 'package:where_my_team/common/widgets/m_team_component.dart';
import 'package:where_my_team/data/services/reverse_geo_service.dart';
import 'package:where_my_team/manifest.dart';
import 'package:where_my_team/models/model_member.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/presentation/map/cubit/map_cubit.dart';
import 'package:where_my_team/presentation/route/route_route.dart';
import 'package:where_my_team/utils/extensions/context_extension.dart';
import '../cubit/team_map_cubit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final PanelController _panelController = PanelController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<void> inits(LocationData? location) async {
    if (location?.latitude != null && location?.latitude != null) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(location!.latitude!, location.longitude!),
        zoom: 15,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SlidingUpPanel(
      controller: _panelController,
      maxHeight: context.screenSize.height * 0.85,
      minHeight: context.screenSize.height * 0.2,
      backdropEnabled: true,
      backdropColor: Colors.black,
      boxShadow: [],
      color: Colors.transparent,
      body: Stack(
        children: [
          BlocConsumer<MapCubit, MapState>(
            listenWhen: (previous, current) =>
                previous.cameraMap != current.cameraMap,
            listener: (context, state) async {
              if (_controller.isCompleted) {
                if (state.status != MapStatus.initial &&
                    state.cameraMap != null) {
                  final GoogleMapController controller =
                      await _controller.future;
                  controller.animateCamera(state.cameraMap!);
                }
              }
            },
            builder: (context, state) => GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
                bool allow = await context.read<MapCubit>().checkPermission();
                if (allow) {
                  inits(context.read<MapCubit>().currentLocation);
                }
              },
              markers: state.members,
              polylines: state.polylines,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 16),
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
                color:
                    Theme.of(context).scaffoldBackgroundColor.withAlpha(180)),
            child: BlocBuilder<TeamMapCubit, TeamMapState>(
              builder: (context, state) => SearchableDropdown<ModelTeam>.future(
                leadingIcon: Icon(Icons.search),
                hintText: Text(MultiLanguage.of(context).yourTeams),
                margin: const EdgeInsets.all(15),
                futureRequest: () async {
                  List<ModelTeam>? teams =
                      await context.read<TeamMapCubit>().getTeams();
                  if (teams != null) {
                    return teams
                        .map((e) => SearchableDropdownMenuItem<ModelTeam>(
                            label: e.name!,
                            child: MTeamComponent(
                                avatar: e.avatar ??
                                    'avatar/fqAueJqQeKcgMJwJFCjsC2atiHj2/image.png',
                                name: e.name!,
                                isEditable: false),
                            value: e))
                        .toList();
                  }
                  return [];
                },
                onChanged: (ModelTeam? value) {
                  debugPrint(value?.id);
                  if (value != null) {
                    context.read<TeamMapCubit>().changeTeam(value);
                    context.read<MapCubit>().changeTeam(value);
                  }
                },
              ),
            ),
          )
        ],
      ),
      panel: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: context.read<MapCubit>().goToMyLocation,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Icon(Icons.my_location),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                    thickness: 5,
                    indent: 125,
                    endIndent: 125,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<TeamMapCubit, TeamMapState>(
                          buildWhen: (previous, current) =>
                              previous.currentTeam?.id !=
                              current.currentTeam?.id,
                          builder: (context, state) => Text(
                              state.currentTeam?.name ?? "",
                              style: mST18M.copyWith(color: mCPrimary))),
                      TextButton(
                          onPressed: () async {
                            LocationData? coordinate =
                                context.read<MapCubit>().currentLocation;
                            if (coordinate != null) {
                              List<Placemark> marks = await ReverseGeoService()
                                  .getAddress(
                                      latitude: coordinate.latitude!,
                                      longitude: coordinate.longitude!);
                              for (var element in marks) {
                                debugPrint(element.name);
                              }
                            }
                          },
                          // onPressed: context.read<MapCubit>().showRoute,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.deepPurple.withOpacity(0.75),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_city,
                                  color: Colors.purple,
                                ),
                                Text(
                                  'Places',
                                  style: TextStyle(color: Colors.purple),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                  BlocBuilder<TeamMapCubit, TeamMapState>(
                      buildWhen: (previous, current) =>
                          previous.currentTeam?.id != current.currentTeam?.id,
                      builder: (context, state) => FutureBuilder<int>(
                          future: state.currentTeam?.getNumberOfMembers,
                          builder: (context, snapshot) => snapshot.hasData
                              ? Text(
                                  "${snapshot.data ?? 1} ${MultiLanguage.of(context).members}",
                                  style: mST10R,
                                )
                              : const SizedBox.shrink())),
                  Expanded(
                      child: BlocBuilder<TeamMapCubit, TeamMapState>(
                    builder: (context, state) => MediaQuery.removeViewPadding(
                      removeTop: true,
                      context: context,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return FutureBuilder<Map<String, Object?>?>(
                                future: context
                                    .read<TeamMapCubit>()
                                    .getInfoMember(index),
                                builder: (context, snapshot) => snapshot
                                            .hasData &&
                                        snapshot.data != null
                                    ? MMemberRouteComponent(
                                        avatar: snapshot.data!['avatar']
                                                as String? ??
                                            'avatar/fqAueJqQeKcgMJwJFCjsC2atiHj2/image.png',
                                        batteryLevel:
                                            snapshot.data!['battery'] as int? ??
                                                0,
                                        name: snapshot.data!['name'].toString(),
                                        location: snapshot.data!['location']
                                            .toString(),
                                        lastOnline: snapshot.data!['lastOnline']
                                            .toString(),
                                        icon: Icons.favorite_outline,
                                        activeIcon: Icons.favorite,
                                        initState: snapshot.data!['isFavourite']
                                                as bool? ??
                                            false,
                                        onPressedToggleIconButton: null,
                                        onTap: () {
                                          _panelController.close();
                                          context
                                              .read<MapCubit>()
                                              .focusToMember(
                                                  state.teamMembers?[index]);
                                        },
                                        routeSlidableAction: (_) async =>
                                            XMDRouter.pushNamed(
                                                routerIds[RouteRoute]!,
                                                arguments: {
                                              'user': await state
                                                  .teamMembers?[index].userEx
                                            }),
                                      )
                                    : const LinearProgressIndicator());
                          },
                          itemCount: state.teamMembers?.length ?? 0),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

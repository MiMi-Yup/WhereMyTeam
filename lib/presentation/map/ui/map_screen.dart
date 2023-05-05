import 'dart:async';

import 'package:configuration/route/xmd_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:where_my_team/common/widgets/m_member_component.dart';
import 'package:where_my_team/common/widgets/m_member_route_component.dart';
import 'package:where_my_team/common/widgets/m_team_component.dart';
import 'package:where_my_team/manifest.dart';
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
            listener: (context, state) async {
              if (_controller.isCompleted) {
                if (state.status != MapStatus.initial &&
                    state.cameraMap != null) {
                  final GoogleMapController controller =
                      await _controller.future;
                  // controller.animateCamera(
                  //     CameraUpdate.newCameraPosition(CameraPosition(
                  //   target: LatLng(state.focusLocation!.latitude!,
                  //       state.focusLocation!.longitude!),
                  //   zoom: 16,
                  // )));
                  controller.animateCamera(state.cameraMap!);
                }
              }
            },
            builder: (context, state) => GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
                inits(await context.read<MapCubit>().getCurrentLocation());
                // bool allow =
                //     await context.read<MapCubit>().checkPermission();
                // if (allow) {
                //   Stream<LocationData>? stream =
                //       await context.read<MapCubit>().getStream();
                //   if (stream != null) inits(stream);
                // }
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
                color: Colors.grey.withAlpha(240)),
            child: BlocBuilder<TeamMapCubit, TeamMapState>(
              builder: (context, state) => SearchableDropdown<ModelTeam>.future(
                leadingIcon: Icon(Icons.search),
                hintText: const Text('Your teams'),
                margin: const EdgeInsets.all(15),
                futureRequest: () async {
                  List<ModelTeam>? teams =
                      await context.read<TeamMapCubit>().getTeams();
                  if (teams != null) {
                    return teams
                        .map((e) => SearchableDropdownMenuItem<ModelTeam>(
                            label: e.name!,
                            child: MTeamComponent(
                                avatar:
                                    'https://www.rd.com/wp-content/uploads/2020/11/redo-cat-meme6.jpg?w=1414',
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
                    context
                        .read<TeamMapCubit>()
                        .changeTeam(value)
                        .then((_) => context.read<MapCubit>().showMembers());
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
                  onTap: () => null,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
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
                  color: Colors.white,
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
                      Text('People',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                              fontSize: 18)),
                      TextButton(
                          onPressed: context.read<MapCubit>().showRoute,
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
                  Text('38 members'),
                  Expanded(
                      child: BlocBuilder<TeamMapCubit, TeamMapState>(
                    builder: (context, state) => MediaQuery.removeViewPadding(
                      removeTop: true,
                      context: context,
                      child: ListView.separated(
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
                                        avatar:
                                            'https://www.rd.com/wp-content/uploads/2020/11/redo-cat-meme6.jpg?w=1414',
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
                                              .focusToMember(index);
                                        },
                                        routeSlidableAction: (_) =>
                                            XMDRouter.pushNamed(
                                                routerIds[RouteRoute]!),
                                      )

                                    // GestureDetector(
                                    //     onTap: () {
                                    //       //TODO focus to member when click
                                    //       _panelController.close();
                                    //       context.read<MapCubit>().focusToMember(index);
                                    //     },
                                    //     child: Container(
                                    //       height: 100,
                                    //       decoration:
                                    //           BoxDecoration(color: Colors.transparent),
                                    //       child: Row(
                                    //         children: [
                                    //           Expanded(
                                    //               child: Row(
                                    //             children: [
                                    //               Stack(
                                    //                 alignment: Alignment.center,
                                    //                 children: [
                                    //                   SizedBox(
                                    //                     height: 80,
                                    //                     width: 80,
                                    //                     child: CircleAvatar(
                                    //                         foregroundImage: NetworkImage(
                                    //                             'https://www.rd.com/wp-content/uploads/2020/11/redo-cat-meme6.jpg?w=1414')),
                                    //                   ),
                                    //                   Align(
                                    //                     alignment:
                                    //                         Alignment.bottomCenter,
                                    //                     child: Container(
                                    //                       padding: EdgeInsets.only(
                                    //                           left: 2.0, right: 2.0),
                                    //                       decoration: BoxDecoration(
                                    //                           color: Colors.white,
                                    //                           borderRadius:
                                    //                               BorderRadius.all(
                                    //                                   Radius.circular(
                                    //                                       8.0)),
                                    //                           boxShadow: [
                                    //                             BoxShadow(
                                    //                               color: Colors.grey,
                                    //                               blurRadius: 4,
                                    //                               offset: Offset(2,
                                    //                                   2), // Shadow position
                                    //                             )
                                    //                           ]),
                                    //                       child: Row(
                                    //                         children: [
                                    //                           Icon(Icons.battery_5_bar),
                                    //                           Text(
                                    //                               '${snapshot.data!['battery']}%')
                                    //                         ],
                                    //                       ),
                                    //                     ),
                                    //                   )
                                    //                 ],
                                    //               ),
                                    //               SizedBox(width: 10.0),
                                    //               Column(
                                    //                 crossAxisAlignment:
                                    //                     CrossAxisAlignment.start,
                                    //                 mainAxisSize: MainAxisSize.min,
                                    //                 children: [
                                    //                   Text(
                                    //                       snapshot.data!['name']
                                    //                           .toString(),
                                    //                       style: TextStyle(
                                    //                           fontWeight:
                                    //                               FontWeight.bold,
                                    //                           fontSize: 16,
                                    //                           color:
                                    //                               Colors.deepPurple)),
                                    //                   Text(
                                    //                       snapshot.data!['location']
                                    //                           .toString(),
                                    //                       style: TextStyle(
                                    //                           fontSize: 16,
                                    //                           color:
                                    //                               Colors.deepPurple)),
                                    //                   Text(
                                    //                       snapshot.data!['lastOnline']
                                    //                           .toString(),
                                    //                       style: TextStyle(
                                    //                           fontSize: 16,
                                    //                           color: Colors.deepPurple))
                                    //                 ],
                                    //               )
                                    //             ],
                                    //           )),
                                    //           MToggleIconButton(
                                    //             activeIcon: Icons.favorite,
                                    //             unactiveIcon: Icons.favorite_outline,
                                    //             initState: snapshot.data!['isFavourite']
                                    //                     as bool? ??
                                    //                 false,
                                    //             onPressed: null,
                                    //           )
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   )
                                    : const Placeholder());
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.grey.withAlpha(100),
                              thickness: 1.0,
                            );
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

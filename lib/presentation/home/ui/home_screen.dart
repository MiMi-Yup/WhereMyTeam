import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:where_my_team/common/widgets/m_toggle_icon_button.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/presentation/home/cubit/map_cubit.dart';
import 'package:where_my_team/utils/extensions/context_extension.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        zoom: 20,
      )));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              label: "Explore", icon: Icon(Icons.location_pin)),
          BottomNavigationBarItem(label: "Person", icon: Icon(Icons.person)),
          BottomNavigationBarItem(label: "Setting", icon: Icon(Icons.settings))
        ]),
        body: SlidingUpPanel(
          controller: _panelController,
          maxHeight: context.screenSize.height * 0.9,
          minHeight: context.screenSize.height * 0.1,
          backdropEnabled: true,
          backdropColor: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          body: Stack(
            children: [
              BlocConsumer<MapCubit, MapState>(
                listener: (context, state) async {
                  if (_controller.isCompleted) {
                    if (state.focusLocation != null) {
                      final GoogleMapController controller =
                          await _controller.future;
                      controller.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(state.focusLocation!.latitude!,
                            state.focusLocation!.longitude!),
                        zoom: 15,
                      )));
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) =>
                          SearchableDropdown<ModelTeam>.future(
                        hintText: const Text('Your teams'),
                        margin: const EdgeInsets.all(15),
                        futureRequest: () async {
                          List<ModelTeam>? teams =
                              await context.read<HomeCubit>().getTeams();
                          if (teams != null) {
                            return teams
                                .map((e) =>
                                    SearchableDropdownMenuItem<ModelTeam>(
                                        label: e.name!,
                                        child: Text(e.name!),
                                        value: e))
                                .toList();
                          }
                          return null;
                        },
                        // items: List.generate(
                        //     10,
                        //     (index) => SearchableDropdownMenuItem(
                        //         label: "Hello $index",
                        //         child: Text("Hello ---$index"))),
                        // items: state.user?.team
                        //     ?.map((e) => SearchableDropdownMenuItem(
                        //         value: e.id,
                        //         label: e.name ?? e.id.toString(),
                        //         child: Container(
                        //           height: 100,
                        //           decoration:
                        //               BoxDecoration(color: Colors.transparent),
                        //           child: Row(
                        //             children: [
                        //               Expanded(
                        //                   child: Row(
                        //                 children: [
                        //                   SizedBox(
                        //                     height: 80,
                        //                     width: 80,
                        //                     child: CircleAvatar(
                        //                         foregroundImage: NetworkImage(
                        //                             'https://www.rd.com/wp-content/uploads/2020/11/redo-cat-meme6.jpg?w=1414')),
                        //                   ),
                        //                   SizedBox(width: 10.0),
                        //                   Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     mainAxisSize: MainAxisSize.min,
                        //                     children: [
                        //                       Text('Team: ${e.id}',
                        //                           style: TextStyle(
                        //                               fontWeight:
                        //                                   FontWeight.bold,
                        //                               fontSize: 16,
                        //                               color: Colors.green)),
                        //                       Text('48 members',
                        //                           style: TextStyle(
                        //                               fontSize: 16,
                        //                               color: Colors.green)),
                        //                     ],
                        //                   )
                        //                 ],
                        //               ))
                        //             ],
                        //           ),
                        //         )))
                        //     .toList(),
                        onChanged: (ModelTeam? value) {
                          debugPrint(value?.id);
                          if (value != null) {
                            context.read<HomeCubit>().changeTeam(value);
                          }
                        },
                      ),
                    )),
                    GestureDetector(
                      onTap: context.read<HomeCubit>().logOut,
                      child: CircleAvatar(
                          foregroundImage: NetworkImage(
                              'https://www.rd.com/wp-content/uploads/2020/11/redo-cat-meme6.jpg?w=1414')),
                    )
                  ],
                ),
              )
            ],
          ),
          panel: Container(
            padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                        onPressed: null,
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
                Expanded(
                    child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) => ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FutureBuilder<Map<String, Object?>?>(
                            future:
                                context.read<HomeCubit>().getInfoMember(index),
                            builder: (context, snapshot) => snapshot.hasData &&
                                    snapshot.data != null
                                ? GestureDetector(
                                    onTap: () {
                                      //TODO focus to member when click
                                      _panelController.close();
                                    },
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 80,
                                                    width: 80,
                                                    child: CircleAvatar(
                                                        foregroundImage:
                                                            NetworkImage(
                                                                'https://www.rd.com/wp-content/uploads/2020/11/redo-cat-meme6.jpg?w=1414')),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 2.0,
                                                          right: 2.0),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8.0)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              blurRadius: 4,
                                                              offset: Offset(2,
                                                                  2), // Shadow position
                                                            )
                                                          ]),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons
                                                              .battery_5_bar),
                                                          Text(
                                                              '${snapshot.data!['battery']}%')
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(width: 10.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                      snapshot.data!['name']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Colors
                                                              .deepPurple)),
                                                  Text(
                                                      snapshot.data!['location']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors
                                                              .deepPurple)),
                                                  Text(
                                                      snapshot
                                                          .data!['lastOnline']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors
                                                              .deepPurple))
                                                ],
                                              )
                                            ],
                                          )),
                                          MToggleIconButton(
                                            activeIcon: Icons.favorite,
                                            unactiveIcon:
                                                Icons.favorite_outline,
                                            initState:
                                                snapshot.data!['isFavourite']
                                                        as bool? ??
                                                    false,
                                            onPressed: null,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : const Placeholder());
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey.withAlpha(100),
                          thickness: 1.0,
                        );
                      },
                      itemCount: state.teamMembers?.length ?? 0),
                ))
              ],
            ),
          ),
        ));
  }
}

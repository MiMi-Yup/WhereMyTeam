import 'dart:async';

import 'package:configuration/route/xmd_router.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:where_my_team/common/widgets/m_section.dart';
import 'package:where_my_team/manifest.dart';
import 'package:where_my_team/presentation/detail_route/detail_route_route.dart';
import 'package:where_my_team/utils/extensions/context_extension.dart';

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
        title: Text("Route"),
        actions: [
          IconButton(onPressed: () => null, icon: Icon(Icons.analytics))
        ],
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          MSection(
              title: "Today",
              content: GestureDetector(
                onTap: () => XMDRouter.pushNamed(routerIds[DetailRouteRoute]!),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.motorcycle,
                          size: 48,
                        ),
                        Column(
                          children: [
                            Text(
                              "125 mins Drive",
                              style: mST20M,
                            ),
                            Text("7:25 am - 7:30 am")
                          ],
                        ),
                        IntrinsicHeight(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all()),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  children: [
                                    Text("Top speed"),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text("60km/h")
                                  ],
                                ),
                                VerticalDivider(
                                  thickness: 2.0,
                                  color: Colors.grey,
                                  width: 30,
                                ),
                                Column(
                                  children: [
                                    Text("Distance"),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text("23.4km")
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.screenSize.height * 0.4,
                      child: AbsorbPointer(
                        absorbing: true,
                        child: GoogleMap(
                          initialCameraPosition: _kGooglePlex,
                          liteModeEnabled: true,
                          mapToolbarEnabled: false,
                          mapType: MapType.hybrid,
                          onMapCreated: (controller) {
                            Completer<GoogleMapController> _controller =
                                Completer<GoogleMapController>();
                            _controller.complete(controller);
                            _controllers
                                .addAll({(count++).toString(): _controller});
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )).builder(),
        ],
      ),
    );
  }
}

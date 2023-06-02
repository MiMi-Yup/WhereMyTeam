import 'dart:async';

import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:where_my_team/models/model_route.dart';
import 'package:where_my_team/utils/extensions/context_extension.dart';
import 'package:where_my_team/utils/latlngbounds_extension.dart';
import 'package:where_my_team/utils/time_util.dart';

class MRouteOverview extends StatelessWidget {
  final List<LatLng> coordinates;
  final ModelRoute route;

  MRouteOverview({super.key, required this.coordinates, required this.route});

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Set<Polyline> polylines = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );

  void drawRoute() async {
    final GoogleMapController control = await _controller.future;
    if (coordinates.isNotEmpty) {
      control.moveCamera(CameraUpdate.newLatLngBounds(
          LatLngBoundsExtension.routeLatLngBounds(coordinates), 50));
    }
    control.dispose();
  }

  @override
  Widget build(BuildContext context) {
    polylines.add(Polyline(
        polylineId: PolylineId(route.id!),
        color: Colors.red,
        width: 5,
        patterns: [PatternItem.dot, PatternItem.dot],
        points: coordinates));
    Future.delayed(const Duration(milliseconds: 250), drawRoute);

    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: 10.0,
          ),
          Icon(
            Icons.motorcycle,
            size: 48,
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${route.endTime?.toDate().difference(route.startTime!.toDate()).inMinutes} mins Drive",
                style: mST20M,
              ),
              Text(
                  "${route.startTime?.toShortDateTime} - ${route.endTime?.toShortDateTime}")
            ],
          ),
        ]),
        IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    Text("Top speed"),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("${route.maxSpeed}km/h")
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
                    Text("${route.distance}km")
                  ],
                ),
              ],
            ),
          ),
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
              polylines: polylines,
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
            ),
          ),
        )
      ],
    );
  }
}

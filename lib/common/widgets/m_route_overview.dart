import 'dart:async';

import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:where_my_team/models/model_route.dart';
import 'package:where_my_team/models/model_type_route.dart';
import 'package:where_my_team/utils/extensions/context_extension.dart';
import 'package:where_my_team/utils/latlngbounds_extension.dart';
import 'package:where_my_team/utils/time_util.dart';

class MRouteOverview extends StatefulWidget {
  final List<LatLng> coordinates;
  final ModelRoute route;
  final Set<Polyline> polylines = {};

  MRouteOverview({super.key, required this.coordinates, required this.route}) {}

  @override
  State<MRouteOverview> createState() => _MRouteOverviewState();
}

class _MRouteOverviewState extends State<MRouteOverview>
    with SingleTickerProviderStateMixin {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: 10.0,
          ),
          SizedBox(
            height: 48,
            width: 48,
            child: FutureBuilder<ModelTypeRoute?>(
                future: widget.route.typeRouteEx,
                builder: (context, snapshot) {
                  switch (snapshot.data?.name) {
                    case 'walk':
                      return const Icon(Icons.directions_walk, size: 48);
                    case 'cycle':
                      return const Icon(Icons.directions_bike, size: 48);
                    case 'bike':
                      return const Icon(Icons.motorcycle, size: 48);
                    case 'roll':
                      return const Icon(Icons.directions_car, size: 48);
                    case 'nothing':
                    default:
                      return const SizedBox.shrink();
                  }
                }),
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.route.endTime?.toDate().difference(widget.route.startTime!.toDate()).inMinutes} ${MultiLanguage.of(context).mins}",
                style: mST20M,
              ),
              Text(
                  "${widget.route.startTime?.toShortDateTime} - ${widget.route.endTime?.toShortDateTime}")
            ],
          ),
        ]),
        IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    Text(MultiLanguage.of(context).topSpeed),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("${widget.route.maxSpeed.toStringAsFixed(2)}m/s")
                  ],
                ),
                VerticalDivider(
                  thickness: 2.0,
                  color: Colors.grey,
                  width: 30,
                ),
                Column(
                  children: [
                    Text(MultiLanguage.of(context).distance),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("${widget.route.distance.toStringAsFixed(2)}m")
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
              polylines: widget.polylines,
              onMapCreated: (controller) {
                _controller.complete(controller);
                Future.delayed(const Duration(seconds: 1), () {
                  if (widget.coordinates.isNotEmpty) {
                    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(
                        LatLngBoundsExtension.routeLatLngBounds(
                            widget.coordinates),
                        1);
                    controller.animateCamera(cameraUpdate);
                    setState(() {
                      if (widget.coordinates.isNotEmpty) {
                        widget.polylines.add(Polyline(
                            polylineId: PolylineId(widget.route.id!),
                            color: Colors.red,
                            width: 5,
                            points: widget.coordinates));
                      }
                    });
                  }
                });
              },
            ),
          ),
        )
      ],
    );
  }
}

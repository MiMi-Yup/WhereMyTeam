import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:where_my_team/common/widgets/timeline_modified_transaction.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/utils/extensions/context_extension.dart';

class DetailRouteScreen extends StatelessWidget {
  DetailRouteScreen({super.key});

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final PanelController _panelController = PanelController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Route #03"),
        actions: [
          IconButton(onPressed: () => null, icon: Icon(Icons.qr_code)),
          PopupMenuButton<int>(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("Hide")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("Delete")
                  ],
                ),
              )
            ],
            offset: Offset(0, 50),
            onSelected: null,
            icon: Icon(Icons.more_horiz),
          )
        ],
      ),
      body: SlidingUpPanel(
        controller: _panelController,
        maxHeight: context.screenSize.height * 0.7,
        minHeight: context.screenSize.height * 0.15,
        backdropEnabled: true,
        backdropColor: Colors.black,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        color: Colors.white,
        body: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            mapToolbarEnabled: false,
            onMapCreated: (GoogleMapController controller) =>
                _controller.complete(controller)),
        panel: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Divider(
                color: Colors.grey.withOpacity(0.5),
                thickness: 5,
                indent: 125,
                endIndent: 125,
              ),
            ),
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
            Expanded(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: TimelineRoute(
                  routes: List.generate(
                      10,
                      (index) => ModelLocation(
                          id: null,
                          user: null,
                          route: null,
                          timestamp: Timestamp.now(),
                          altitude: null,
                          latitude: null,
                          longitude: null,
                          satelliteNumber: null,
                          speed: null))),
            ))
          ],
        ),
      ),
    );
  }
}

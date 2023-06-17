import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:where_my_team/common/widgets/m_route.dart';
import 'package:where_my_team/models/model_location.dart';
import 'package:where_my_team/utils/extensions/location_extension.dart';
import 'package:where_my_team/utils/time_util.dart';

import '../timelines/timelines.dart';

class TimelineRoute extends StatelessWidget {
  final List<ModelLocation> routes;
  const TimelineRoute({Key? key, required this.routes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: mST16R.copyWith(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: Color(0xff989898),
            indicatorTheme: const IndicatorThemeData(
              position: 0,
              size: 20.0,
            ),
            connectorTheme: const ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: routes.length - 1,
            contentsBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${routes[index].timestamp?.toDate().toVNFormat} - ${routes[index + 1].timestamp?.toDate().toVNFormat}',
                      style: mST18M,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: MRoute(
                          distance: routes[index].distance(routes[index + 1]),
                          speed: routes[index + 1].speed ?? 0.0,
                          location: 'API Location'),
                    )
                  ],
                ),
              );
            },
            indicatorBuilder: (_, index) {
              if (index == 0) {
                return DotIndicator(
                  color: Colors.green,
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                    size: 12.0,
                  ),
                );
              }
              if (index == routes.length - 2) {
                return DotIndicator(
                  color: Colors.orange,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12.0,
                  ),
                );
              }
              return OutlinedDotIndicator(
                  borderWidth: 2.5, color: Colors.amber);
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

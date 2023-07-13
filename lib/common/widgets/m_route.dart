import 'package:flutter/material.dart';

class MRoute extends StatelessWidget {
  final double distance;
  final double speed;
  final String location;
  const MRoute(
      {super.key,
      required this.distance,
      required this.speed,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            '${distance.toStringAsFixed(2)}m - ${speed.toStringAsFixed(2)}m/s'),
        const SizedBox(
          height: 10.0,
        ),
        Text(location)
      ],
    );
  }
}

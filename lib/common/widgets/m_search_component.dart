import 'package:flutter/material.dart';

class MSearchComponent extends StatelessWidget {
  final String networkImage;
  final String name;
  const MSearchComponent(
      {super.key, required this.networkImage, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: CircleAvatar(foregroundImage: NetworkImage(networkImage)),
        ),
        Text(name)
      ],
    );
  }
}

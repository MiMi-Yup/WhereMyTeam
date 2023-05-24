import 'dart:math';

import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';

class MUserComponent extends StatelessWidget {
  final String avatar;
  final String name;
  final String? title;
  final void Function()? onPressed;
  const MUserComponent(
      {super.key,
      required this.avatar,
      required this.name,
      this.title,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors
                    .primaries[Random().nextInt(Colors.primaries.length)]
                    .withAlpha(120)),
            child: Image(
                height: 40.0,
                width: 40.0,
                image: NetworkImage(avatar, scale: 1.0)),
          ),
          Text(name, style: mST16R),
          if (title != null)
            Text(
              title!,
              style: mST14R.copyWith(color: Colors.grey),
            )
        ],
      ),
    );
  }
}

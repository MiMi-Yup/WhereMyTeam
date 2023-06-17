import 'dart:math';
import 'dart:typed_data';

import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:where_my_team/data/data_source/remote/cloud_storage_service.dart';

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
      child: SizedBox(
        width: 75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 75,
              width: 75,
              child: FutureBuilder<Uint8List?>(
                  future: CloudStorageService.downloadFile(avatar),
                  builder: (context, snapshot) => snapshot.hasData
                      ? CircleAvatar(
                          foregroundImage:
                              MemoryImage(snapshot.data!, scale: 1.0))
                      : const SizedBox.shrink()),
            ),
            Expanded(
                child: Text(
              name,
              style: mST16R,
              overflow: TextOverflow.ellipsis,
            )),
            if (title != null)
              Expanded(
                child: Text(
                  title!,
                  style: mST14R.copyWith(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              )
          ],
        ),
      ),
    );
  }
}

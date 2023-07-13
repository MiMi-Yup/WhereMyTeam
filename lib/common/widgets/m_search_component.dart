import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wmteam/data/data_source/remote/cloud_storage_service.dart';

class MSearchComponent extends StatelessWidget {
  final String avatar;
  final String name;
  final void Function()? onPressed;
  const MSearchComponent(
      {super.key, required this.avatar, required this.name, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: FutureBuilder<Uint8List?>(
                future: CloudStorageService.downloadFile(avatar),
                builder: (context, snapshot) => snapshot.hasData
                    ? CircleAvatar(
                        foregroundImage:
                            MemoryImage(snapshot.data!, scale: 1.0))
                    : const SizedBox.shrink()),
          ),
          Text(name)
        ],
      ),
    );
  }
}

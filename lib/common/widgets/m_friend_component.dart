import 'dart:typed_data';

import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:wmteam/data/data_source/remote/cloud_storage_service.dart';

class MFriendComponent extends StatelessWidget {
  final void Function()? onTap;
  final String avatar;
  final String name;
  final String? nickname;
  final String? location;
  final String? lastOnline;
  final void Function()? onUnFriend;

  const MFriendComponent(
      {super.key,
      this.onTap,
      required this.avatar,
      required this.name,
      this.nickname,
      this.location,
      this.lastOnline,
      this.onUnFriend});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Row(
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
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(name,
                      style: mST16M.copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? null
                              : mCPrimary)),
                  if (nickname != null) Text(nickname!, style: mST14R),
                  if (location != null) Text(location!, style: mST14R),
                  if (lastOnline != null) Text(lastOnline!, style: mST14R)
                ],
              )
            ],
          )),
          IconButton(onPressed: onUnFriend, icon: const Icon(Icons.remove)),
        ],
      ),
    );
  }
}

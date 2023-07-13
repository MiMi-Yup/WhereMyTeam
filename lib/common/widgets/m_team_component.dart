import 'dart:typed_data';

import 'package:configuration/l10n/l10n.dart';
import 'package:configuration/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wmteam/data/data_source/remote/cloud_storage_service.dart';

class MTeamComponent extends StatefulWidget {
  final void Function()? onTap;
  final String avatar;
  final String name;
  final int? members;
  final bool isEditable;
  final AnimationController? parentController;
  final Future<bool> Function(BuildContext)? leaveSlidableAction;
  final void Function(BuildContext)? inviteSlidableAction;
  final void Function(BuildContext)? viewInMapSlidableAction;

  const MTeamComponent(
      {super.key,
      this.onTap,
      required this.avatar,
      required this.name,
      this.members,
      required this.isEditable,
      this.parentController,
      this.leaveSlidableAction,
      this.inviteSlidableAction,
      this.viewInMapSlidableAction});

  @override
  State<MTeamComponent> createState() => _MTeamComponentState();
}

class _MTeamComponentState extends State<MTeamComponent>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(seconds: 0));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MTeamComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_controller!.isDismissed) {
      _controller?.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Container(
      height: 80,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: FutureBuilder<Uint8List?>(
                    future: CloudStorageService.downloadFile(widget.avatar),
                    builder: (context, snapshot) => snapshot.hasData
                        ? CircleAvatar(
                            foregroundImage:
                                MemoryImage(snapshot.data!, scale: 1.0))
                        : const SizedBox.shrink()),
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.name,
                      style: mST18M.copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? null
                              : mCPrimary)),
                  if (widget.members != null)
                    Text(
                        "${widget.members} ${MultiLanguage.of(context).members}",
                        style: mST16R),
                ],
              )
            ],
          ))
        ],
      ),
    );
    final slidable = SizeTransition(
      sizeFactor: ReverseAnimation(CurvedAnimation(
        curve: Curves.linear,
        parent: _controller!,
      )),
      child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
              margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10.0)),
              child: widget.isEditable
                  ? Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                              onPressed: (context) async {
                                if (widget.leaveSlidableAction != null) {
                                  final result = await widget
                                      .leaveSlidableAction!(context);
                                  if (result) {
                                    _controller?.forward();
                                  }
                                } else {
                                  _controller?.forward();
                                }
                              },
                              backgroundColor: Color.fromARGB(255, 34, 72, 2),
                              foregroundColor: Colors.white,
                              icon: Icons.logout,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          SlidableAction(
                              onPressed: widget.inviteSlidableAction,
                              backgroundColor: Color(0xFF7BC043),
                              foregroundColor: Colors.white,
                              icon: Icons.add),
                          SlidableAction(
                              onPressed: widget.viewInMapSlidableAction,
                              backgroundColor: Color(0xFF0392CF),
                              foregroundColor: Colors.white,
                              icon: Icons.map,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                        ],
                      ),
                      child: content,
                    )
                  : content)),
    );

    return widget.parentController == null
        ? slidable
        : SizeTransition(
            sizeFactor: CurvedAnimation(
              curve: Curves.linear,
              parent: widget.parentController!,
            ),
            child: slidable,
          );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:where_my_team/common/widgets/m_toggle_icon_button.dart';

class MMemberRouteComponent extends StatefulWidget {
  final void Function()? onTap;
  final String avatar;
  final int batteryLevel;
  final String name;
  final String? nickname;
  final String? location;
  final String? lastOnline;
  final IconData? icon;
  final IconData? activeIcon;
  final bool initState;
  final bool Function()? onPressedToggleIconButton;
  final AnimationController? parentController;
  final void Function(BuildContext)? routeSlidableAction;

  const MMemberRouteComponent(
      {super.key,
      this.onTap,
      required this.avatar,
      required this.batteryLevel,
      required this.name,
      this.nickname,
      this.location,
      this.lastOnline,
      this.icon,
      this.activeIcon,
      this.initState = false,
      this.onPressedToggleIconButton,
      this.parentController,
      this.routeSlidableAction});

  @override
  State<MMemberRouteComponent> createState() => _MMemberRouteComponentState();
}

class _MMemberRouteComponentState extends State<MMemberRouteComponent>
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
  void didUpdateWidget(MMemberRouteComponent oldWidget) {
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
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircleAvatar(
                        foregroundImage: NetworkImage(widget.avatar)),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.only(left: 2.0, right: 2.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              offset: Offset(2, 2), // Shadow position
                            )
                          ]),
                      child: Row(
                        children: [
                          Icon(Icons.battery_5_bar),
                          Text('${widget.batteryLevel}%')
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepPurple)),
                  if (widget.nickname != null)
                    Text(widget.nickname!,
                        style:
                            TextStyle(fontSize: 16, color: Colors.deepPurple)),
                  if (widget.location != null)
                    Text(widget.location!,
                        style:
                            TextStyle(fontSize: 16, color: Colors.deepPurple)),
                  if (widget.lastOnline != null)
                    Text(widget.lastOnline!,
                        style:
                            TextStyle(fontSize: 16, color: Colors.deepPurple))
                ],
              )
            ],
          )),
          if (widget.icon != null)
            MToggleIconButton(
              activeIcon: Icons.favorite,
              icon: widget.icon!,
              initState: widget.activeIcon == null ? false : widget.initState,
              onPressed: widget.onPressedToggleIconButton,
            )
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
              child: Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.2,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                        onPressed: widget.routeSlidableAction,
                        backgroundColor: Color(0xFF0392CF),
                        foregroundColor: Colors.white,
                        icon: Icons.route,
                        borderRadius: BorderRadius.circular(10.0)),
                  ],
                ),
                child: content,
              ))),
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
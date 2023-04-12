import 'package:flutter/material.dart';

class MToggleIconButton extends StatefulWidget {
  final IconData activeIcon;
  final IconData unactiveIcon;
  final bool initState;
  final bool Function()? onPressed;
  const MToggleIconButton(
      {super.key,
      required this.activeIcon,
      required this.unactiveIcon,
      this.initState = false,
      this.onPressed});

  @override
  State<MToggleIconButton> createState() => _MToggleIconButtonState();
}

class _MToggleIconButtonState extends State<MToggleIconButton> {
  late bool state;
  @override
  void initState() {
    super.initState();
    state = widget.initState;
  }

  void toogleEvent() {
    setState(
        () => state = widget.onPressed == null ? !state : widget.onPressed!());
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: toogleEvent,
        icon: Icon(state ? widget.activeIcon : widget.unactiveIcon));
  }
}

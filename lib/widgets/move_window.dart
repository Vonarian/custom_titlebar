import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class MoveWindow extends StatelessWidget {
  const MoveWindow({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (details) {
          windowManager.startDragging();
        },
        onDoubleTap: () async {
          if (!await windowManager.isMaximized()) {
            await windowManager.maximize();
          } else {
            await windowManager.unmaximize();
          }
        },
        child: child);
  }
}

import 'dart:io';

import 'package:flutter/material.dart' hide MenuItem;
import 'package:window_manager/window_manager.dart';

import 'move_window.dart';



class WindowTitleBar extends StatefulWidget {
  final String? iconPath;
  const WindowTitleBar({Key? key, this.iconPath}) : super(key: key);

  @override
  State<WindowTitleBar> createState() => WindowTitleBarState();
}

class WindowTitleBarState extends State<WindowTitleBar>
    with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MoveWindow(
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                windowManager.minimize();
              },
              hoverColor: Colors.blue.withOpacity(0.1),
              child: Container(
                width: 15,
                height: 15,
                margin: const EdgeInsets.fromLTRB(12, 0, 10, 25.5),
                child: const Icon(Icons.minimize_outlined, color: Colors.blue),
              ),
            ),
            InkWell(
                onTap: () {
                  windowManager.close();
                  exit(0);
                },
                hoverColor: Colors.red.withOpacity(0.1),
                child: Container(
                  alignment: Alignment.center,
                  width: 15,
                  height: 15,
                  margin: const EdgeInsets.fromLTRB(12, 0, 18, 12),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 25,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> _handleClickRestore() async {
    if(widget.iconPath != null){
      await windowManager.setIcon('assets/app_icon.ico');
    }
    windowManager.restore();
    windowManager.show();
  }


  @override
  void onWindowRestore() {
    _handleClickRestore();
    setState(() {});
  }

  @override
  void onWindowMinimize() {
    windowManager.hide();
  }
}

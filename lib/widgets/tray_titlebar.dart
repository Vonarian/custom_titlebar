import 'dart:io';

import 'package:flutter/material.dart' hide MenuItem;
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import 'move_window.dart';


class WindowTitleBarWithTray extends StatefulWidget {
  final String? iconPath;
  const WindowTitleBarWithTray({Key? key, this.iconPath}) : super(key: key);

  @override
  State<WindowTitleBarWithTray> createState() => WindowTitleBarWithTrayState();
}

class WindowTitleBarWithTrayState extends State<WindowTitleBarWithTray>
    with TrayListener, WindowListener {
  @override
  void initState() {
    super.initState();
    trayManager.addListener(this);
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 27.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/app_icon.ico',
                  ),
                ),
              ),
            ),
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

  Future<void> _trayInit() async {
    if(widget.iconPath != null){
      await trayManager.setIcon(
        widget.iconPath!,
      );
    }
    Menu menu = Menu(items: [
      MenuItem(key: 'show-app', label: 'Show'),
      MenuItem.separator(),
      MenuItem(key: 'close-app', label: 'Exit'),
    ]);
    await trayManager.setContextMenu(menu);
  }

  void _trayUnInit() async {
    await trayManager.destroy();
  }

  @override
  void onTrayIconMouseDown() async {
    _handleClickRestore();
    _trayUnInit();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onWindowRestore() {
    setState(() {});
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) async {
    switch (menuItem.key) {
      case 'show-app':
        windowManager.show();
        break;
      case 'close-app':
        windowManager.close();
        break;
    }
  }

  @override
  void onWindowMinimize() {
    windowManager.hide();
    _trayInit();
  }
}

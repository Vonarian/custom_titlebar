import 'package:custom_titlebar/widgets/titlebar.dart';
import 'package:custom_titlebar/widgets/tray_titlebar.dart';
import 'package:flutter/material.dart';

class CustomTitleBar extends StatelessWidget {
  final bool withTray;
  final String? iconPath;
  const CustomTitleBar({Key? key, this.withTray = false, this.iconPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return withTray ? WindowTitleBarWithTray(iconPath: iconPath,) : WindowTitleBar(iconPath: iconPath,);
  }
}
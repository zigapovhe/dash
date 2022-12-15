import 'package:flutter/cupertino.dart';

/// Representation of a tab item in the [ScaffoldWithBottomNavBar]
class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation, required Widget icon, required this.webIcon, String? label, Color? backgroundColor})
      : super(icon: icon, label: label, backgroundColor: backgroundColor);

  final IconData webIcon;

  /// The initial location/path
  final String initialLocation;
}
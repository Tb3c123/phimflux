import 'package:flutter/material.dart';

/// Central Focus Engine managing FocusScopeNodes for TV Sidebar & Main Content Area
class TvFocusEngine {
  static final TvFocusEngine _instance = TvFocusEngine._internal();
  factory TvFocusEngine() => _instance;
  TvFocusEngine._internal();

  final FocusScopeNode sidebarScope = FocusScopeNode(debugLabel: 'SidebarScope');
  final FocusScopeNode mainAreaScope = FocusScopeNode(debugLabel: 'MainAreaScope');

  FocusScopeNode _activeScope = FocusScopeNode();
  FocusScopeNode get activeScope => _activeScope;

  void focusSidebar() {
    _activeScope = sidebarScope;
    sidebarScope.requestFocus();
  }

  void focusMainArea() {
    _activeScope = mainAreaScope;
    mainAreaScope.requestFocus();
  }

  void dispose() {
    sidebarScope.dispose();
    mainAreaScope.dispose();
  }
}

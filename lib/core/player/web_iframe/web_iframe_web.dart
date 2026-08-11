import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

/// Web iframe builder for Flutter Web using HTMLIFrameElement
Widget buildWebIframe(String url, String viewId) {
  ui_web.platformViewRegistry.registerViewFactory(
    viewId,
    (int id) {
      final iframe = web.HTMLIFrameElement()
        ..src = url
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allow = 'autoplay; fullscreen; picture-in-picture'
        ..allowFullscreen = true;
      return iframe;
    },
  );

  return HtmlElementView(viewType: viewId);
}

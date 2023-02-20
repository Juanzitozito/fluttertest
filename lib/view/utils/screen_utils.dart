import 'package:flutter/material.dart';
import 'package:fluttertest/common/enum/screen_size_enum.dart';
import 'package:fluttertest/common/utils/platform_utils.dart';
import 'package:window_manager/window_manager.dart';

class ScreenUtils {
  static bool isSmallScreen(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width < ScreenSizeEnum.sm.maxSize;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static Future<void> initDesktop() async {
    if (!PlatformUtils.isDesktop()) {
      return;
    }
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await _initDesktopWindow();
    });
  }

  static Future<void> _initDesktopWindow() async {
    await windowManager.setTitle("Fluttertest");
    await windowManager.setSize(const Size(500, 600));
    await windowManager.setMinimumSize(const Size(500, 350));
    await windowManager.center();
    await windowManager.show();
  }

  static Future<void> setDesktopFullScreen() async {
    if (!PlatformUtils.isDesktop()) {
      return;
    }
    await windowManager.maximize();
    await windowManager.setMinimumSize(const Size(500, 350));
    await windowManager.show();
  }
}

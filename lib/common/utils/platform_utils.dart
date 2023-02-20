import 'dart:io';

class PlatformUtils {
  static bool isDesktop() {
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }
}

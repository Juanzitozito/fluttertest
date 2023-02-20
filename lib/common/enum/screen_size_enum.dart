enum ScreenSizeEnum {
  xsm,
  sm,
  md,
  lg,
  xl,
}

extension ScreenSizeExt on ScreenSizeEnum {
  double get maxSize {
    switch (this) {
      case ScreenSizeEnum.xsm:
        return 576;
      case ScreenSizeEnum.sm:
        return 768;
      case ScreenSizeEnum.md:
        return 992;
      case ScreenSizeEnum.lg:
        return 1200;
      case ScreenSizeEnum.xl:
        return double.infinity;
    }
  }
}

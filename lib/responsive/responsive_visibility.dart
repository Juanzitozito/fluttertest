import 'package:flutter/material.dart';
import 'package:fluttertest/common/enum/screen_size_enum.dart';
import 'package:fluttertest/view/utils/screen_utils.dart';

class ResponsiveVisibility extends StatelessWidget {
  final ScreenSizeEnum size;
  final Widget child;

  const ResponsiveVisibility({
    Key? key,
    required this.child,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible(context),
      child: child,
    );
  }

  bool isVisible(BuildContext context) {
    double width = ScreenUtils.getWidth(context);
    if (width > size.maxSize) {
      return true;
    }
    return false;
  }

  ScreenSizeEnum getSize(BuildContext context) {
    double width = ScreenUtils.getWidth(context);
    for (ScreenSizeEnum size in ScreenSizeEnum.values) {
      if (width < size.maxSize) {
        return size;
      }
    }
    return ScreenSizeEnum.xl;
  }
}

import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final int? xsm;
  final int? sm;
  final int? md;
  final int? lg;
  final int? xl;
  final Widget? child;
  final int proportion = 12;
  const ResponsiveContainer({
    Key? key,
    this.xsm,
    this.child,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: child ?? Container(),
    );
  }

  int getXsm() {
    return xsm ?? proportion;
  }

  int getSm() {
    return sm ?? getXsm();
  }

  int getMd() {
    return md ?? getSm();
  }

  int getLg() {
    return lg ?? getMd();
  }

  int getXl() {
    return xl ?? getLg();
  }
}

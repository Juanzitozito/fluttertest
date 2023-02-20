import 'package:flutter/material.dart';
import 'package:fluttertest/common/enum/screen_size_enum.dart';
import 'package:fluttertest/responsive/responsive_container.dart';

class ResponsiveRow extends StatelessWidget {
  final List<ResponsiveContainer> children;
  const ResponsiveRow({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: _buildRows(constraints),
        );
      },
    );
  }

  List<Widget> _buildRows(BoxConstraints constraints) {
    _ResponsiveRowBuilder builder = _ResponsiveRowBuilder(
      constraints: constraints,
      children: children,
    );
    return builder.execute();
  }
}

class _ResponsiveRowBuilder {
  final int proportion = 12;

  List<Row> rows = [];
  int cols = 0;
  List<Widget> parts = [];
  ScreenSizeEnum size = ScreenSizeEnum.sm;
  BoxConstraints constraints;
  List<ResponsiveContainer> children;

  _ResponsiveRowBuilder({required this.constraints, required this.children});

  List<Row> execute() {
    size = getSize();
    for (ResponsiveContainer container in children) {
      if (container.child == null) {
        continue;
      }
      int containerProportion = getContainerProportion(container);
      if (containerProportion + cols > proportion) {
        newLine();
      }
      _addListWidget(container, containerProportion);
    }
    rows.add(Row(
      children: parts,
      crossAxisAlignment: CrossAxisAlignment.start,
    ));
    return rows;
  }

  void newLine() {
    rows.add(Row(
      children: parts,
      crossAxisAlignment: CrossAxisAlignment.start,
    ));
    cols = 0;
    parts = [];
  }

  double _getWidth() {
    return constraints.maxWidth;
  }

  void _addListWidget(
    ResponsiveContainer container,
    int containerProportion,
  ) {
    double colSize = _getWidth() / proportion;
    parts.add(SizedBox(
      child: container,
      width: colSize * containerProportion,
    ));
    cols += containerProportion;
  }

  int getContainerProportion(ResponsiveContainer container) {
    int prop = getProportion(container);
    if (prop > proportion) {
      return proportion;
    }
    return prop;
  }

  ScreenSizeEnum getSize() {
    for (ScreenSizeEnum size in ScreenSizeEnum.values) {
      if (_getWidth() < size.maxSize) {
        return size;
      }
    }
    return ScreenSizeEnum.xl;
  }

  int getProportion(ResponsiveContainer container) {
    switch (size) {
      case ScreenSizeEnum.xsm:
        return container.getXsm();
      case ScreenSizeEnum.sm:
        return container.getSm();
      case ScreenSizeEnum.md:
        return container.getMd();
      case ScreenSizeEnum.lg:
        return container.getLg();
      default:
        return container.getXl();
    }
  }
}

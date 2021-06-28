library seamless;

import 'package:flutter/material.dart';

typedef SizeSelector = SizeMode Function(BuildContext context, Size size);

class Seamless extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;
  final SizeSelector sizeSelector;

  static const int _small = 576;
  static const int _medium = 768;
  //static const int _large = 992;
  //static const int _extra_large = 1200;

  WidgetBuilder _getTablet() {
    return tablet ?? mobile;
  }

  WidgetBuilder _getDesktop() {
    return desktop ?? _getTablet();
  }

  static SizeMode _def(BuildContext context, Size size) {
    final w = size.width;

    if (w < _small) return SizeMode.mobile;
    if (w < _medium) return SizeMode.tablet;
    return SizeMode.desktop;
  }

  Seamless({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.sizeSelector: _def,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (c, sz) {
        SizeMode sm = _def(c, sz.biggest);

        sm = sizeSelector(c, sz.biggest);

        if (sm == SizeMode.mobile) return mobile(context);
        if (sm == SizeMode.tablet) return _getTablet()(context);
        return _getDesktop()(context);
      },
    );
  }
}

enum SizeMode {
  mobile,
  tablet,
  desktop,
}

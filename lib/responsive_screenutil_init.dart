import 'package:flutter/widgets.dart';
import 'package:responsive_screen_utils/responsive_screen_utils.dart';


class ResponsiveScreenUtilInit extends StatelessWidget {
  /// A helper widget that initializes [ResponsiveScreenUtilInit]
  ResponsiveScreenUtilInit({
    required this.child,
    this.designSize = ResponsiveScreenUtil.defaultSize,
    this.allowFontScaling = false,
    Key? key,
  }) : super(key: key);

  final Widget child;

  /// The [Size] of the device in the design draft, in dp
  final Size designSize;

  /// Sets whether the font size is scaled according to the system's "font size" assist option
  final bool allowFontScaling;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // ignore: missing_return
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth != 0) {
          ResponsiveScreenUtil.init(
            constraints,
            designSize: designSize,
            allowFontScaling: allowFontScaling,
          );
        }
        return child;
      },
    );
  }
}
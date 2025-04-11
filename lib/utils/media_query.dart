import 'package:accounting_module/core/global_keepings.dart';
import 'package:flutter/widgets.dart';

class MediaQueryUtil {
  static double getScreenWidth() =>
      MediaQuery.of(GlobalKeepings.navigator.currentState!.context).size.width;
  static double getScreenHeight() =>
      MediaQuery.of(GlobalKeepings.navigator.currentState!.context).size.height;
  static bool get isDesktopScreen => getScreenWidth() > 800;
}

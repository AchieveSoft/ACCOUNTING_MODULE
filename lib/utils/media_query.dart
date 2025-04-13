import 'package:accounting_module/core/global_keepings.dart';
import 'package:flutter/widgets.dart';

class MediaQueryUtil {
  static double getScreenWidth() =>
      MediaQuery.of(GlobalKeepings.navigator.currentState!.context).size.width;
  
  static double getScreenHeight() =>
      MediaQuery.of(GlobalKeepings.navigator.currentState!.context).size.height;
  
  static double getScreenWidthPercent(percent) => (getScreenWidth() / 100) * percent;
  
  static double getScreenHeightPercent(percent) => (getScreenHeight() / 100) * percent;

  static bool get isDesktopScreen => getScreenWidth() > 800;
}

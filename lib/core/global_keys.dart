import 'package:flutter/widgets.dart';

class GlobalKeepings {
  static GlobalKey<NavigatorState> navigator = GlobalKey();

  static BuildContext get context => navigator.currentState!.context;
}

import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
import 'package:accounting_module/accounting_app.dart';
// import 'package:window_manager/window_manager.dart';

// Future<void> setWindowsFullScreen() async {
//   if (defaultTargetPlatform == TargetPlatform.windows) {
//     await windowManager.ensureInitialized();

//     windowManager.waitUntilReadyToShow().then((_) async {
//       await windowManager.setFullScreen(true);
//     });
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await setWindowsFullScreen();

  runApp(const AccountingApp());
}

import 'package:accounting_module/constants.dart';
import 'package:accounting_module/core/global_keepings.dart';
import 'package:accounting_module/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommonLoader {
  static bool _isShow = false;

  static Widget _buildDialogContent() => Container(
    width: MediaQueryUtil.getScreenWidth(),
    height: MediaQueryUtil.getScreenHeight(),
    decoration: BoxDecoration(color: Colors.white.withAlpha(0)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LoadingAnimationWidget.twistingDots(
          leftDotColor: Constants.primaryColor1,
          rightDotColor: Constants.primaryColor2,
          size: 150,
        ),
      ],
    ),
  );

  static void show() {
    showDialog(
      context: GlobalKeepings.context,
      builder: (context) => _buildDialogContent(),
    );
    _isShow = true;
  }

  static void hide() {
    if (_isShow) {
      Navigator.of(GlobalKeepings.context).pop();
      _isShow = false;
    }
  }
}

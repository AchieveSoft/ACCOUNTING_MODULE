import 'package:accounting_module/constants.dart';
import 'package:flutter/material.dart';

class CommonStepperItem {
  final String text;
  final String key;
  final Function? onTap;
  final IconData? icon;

  CommonStepperItem({
    required this.text,
    required this.key,
    this.onTap,
    this.icon,
  });
}

// ignore: must_be_immutable
class CommonStepper extends StatefulWidget {
  final List<CommonStepperItem> steps;
  late int currentStepIndex;

  CommonStepper({super.key, required this.steps, String? currentStepKey}) {
    currentStepIndex = steps.indexWhere((item) => item.key == currentStepKey);
  }

  @override
  State<CommonStepper> createState() => _CommonStepperState();
}

class _CommonStepperState extends State<CommonStepper> {
  Widget _buildStepItemLine() =>
      Expanded(child: Container(height: 3, color: Constants.primaryColor2));

  Color _getItemColor({bool? isAccept, bool? isNextStep}) {
    if (isAccept == true) {
      return Constants.primaryColor1;
    } else if (isNextStep == true) {
      return Colors.blueAccent;
    }

    return Colors.white;
  }

  Color _getFontColor({bool? isAccept, bool? isNextStep}) {
    if (isAccept == true || isNextStep == true) {
      return Colors.white;
    }

    return Colors.grey;
  }

  IconData _getItemIcon({
    bool? isAccept,
    bool? isNextStep,
    IconData? defaultIcon,
  }) {
    if (isAccept == true) {
      return Icons.check;
    } else if (isNextStep == true) {
      return defaultIcon ?? Icons.circle_outlined;
    }

    return Icons.circle_outlined;
  }

  Widget _buildStepItem(CommonStepperItem data, int itemIndex) {
    bool isAccept = widget.currentStepIndex >= itemIndex;
    bool isNextStep = (itemIndex - widget.currentStepIndex) == 1;

    return InkWell(
      onTap:
          isAccept
              ? null
              : () {
                data.onTap?.call();
              },
      child: Container(
        width: 150,
        height: 70,
        decoration: BoxDecoration(
          color: _getItemColor(isAccept: isAccept, isNextStep: isNextStep),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Constants.primaryColor1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getItemIcon(
                isAccept: isAccept,
                isNextStep: isNextStep,
                defaultIcon: data.icon,
              ),
              color: _getFontColor(isAccept: isAccept, isNextStep: isNextStep),
            ),
            SizedBox(width: 8),
            Text(
              data.text,
              style: TextStyle(
                color: _getFontColor(
                  isAccept: isAccept,
                  isNextStep: isNextStep,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    for (int index = 0; index <= widget.steps.length - 1; index++) {
      if (index != 0) items.add(_buildStepItemLine());
      items.add(_buildStepItem(widget.steps[index], index));
    }

    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [...items],
      ),
    );
  }
}

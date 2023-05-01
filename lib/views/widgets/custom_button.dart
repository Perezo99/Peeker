import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:peeker/utils/layout.dart';

import '../../utils/color_manager.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String start;
  const CustomButton(this.onPressed, this.start, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Layout.getHeight(90),
      padding: EdgeInsets.symmetric(
        vertical: Layout.getHeight(20),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              start,
              style: TextStyle(fontSize: 15, color: ColorManager.white),
              textAlign: TextAlign.center,
            ),
            Gap(Layout.getWidth(60)),
            Icon(
              Icons.arrow_circle_right,
              size: 30,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}

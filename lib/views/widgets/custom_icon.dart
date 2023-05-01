import 'package:flutter/material.dart';
import 'package:peeker/utils/color_manager.dart';
import 'package:peeker/utils/layout.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Layout.getWidth(45),
      height: Layout.getHeight(30),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            width: Layout.getWidth(38),
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                250,
                45,
                108,
              ),
              borderRadius: BorderRadius.circular(17),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: Layout.getWidth(38),
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                32,
                211,
                234,
              ),
              borderRadius: BorderRadius.circular(17),
            ),
          ),
          Center(
            child: Container(
              height: double.infinity,
              width: Layout.getWidth(38),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(17),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

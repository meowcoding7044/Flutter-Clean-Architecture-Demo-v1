
import 'package:flutter/material.dart';

import '../config/color/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final double height;
  const RoundButton({super.key, this.height = 40,required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color:AppColors.buttonColor
        ),
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}

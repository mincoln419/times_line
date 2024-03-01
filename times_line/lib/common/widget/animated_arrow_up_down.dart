import 'package:times_line/common/cli_common.dart';
import 'package:times_line/common/widget/w_arrow.dart';
import 'package:flutter/material.dart';

class AnimatedArrowUpDown extends StatefulWidget {
  final bool isSelected;
  final double turns;
  const AnimatedArrowUpDown(this.isSelected, this.turns, {super.key});

  @override
  State<AnimatedArrowUpDown> createState() => _AnimatedArrowUpDownState();
}

class _AnimatedArrowUpDownState extends State<AnimatedArrowUpDown> {
  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: widget.turns,
      duration: 300.ms,
      child: Arrow(
        size: 30,
        direction: widget.isSelected? AxisDirection.up: AxisDirection.down,
      ),
    );
  }
}

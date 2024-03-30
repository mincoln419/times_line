import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:times_line/common/common.dart';

class WritePlanItem extends StatefulWidget {

  final int index;
  final TextEditingController tec;
  const WritePlanItem( {super.key, required this.index, required this.tec});

  @override
  State<WritePlanItem> createState() => _WritePlanItemState();
}

class _WritePlanItemState extends State<WritePlanItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(right: 10,),
                child: widget.index.text.make()),
            Container(
              child: Placeholder(),
              width: 80,
            ),
            Expanded(
              child: TextField(
                controller: widget.tec,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

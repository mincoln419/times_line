import 'package:times_line/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThreeLineDiary extends ConsumerStatefulWidget {
  const ThreeLineDiary({super.key});

  @override
  ConsumerState<ThreeLineDiary> createState() => _ThreeLineDiaryState();
}

class _ThreeLineDiaryState extends ConsumerState<ThreeLineDiary> {

  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
      Container(
        height: 100,
        color: Colors.red,
        child: TitleEditor(controller),
      ),
      Container(
        height: 100,
        color: Colors.blue,
        child: TitleEditor(controller),
      ),
      Container(
        height: 100,
        color: Colors.green,
        child: TitleEditor(controller),
      )
      ],
    );
  }
}


class TitleEditor extends StatelessWidget {
  final TextEditingController controller;

  const TitleEditor(this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        '일기 내용을 적으세요'.text.bold.make(),
        height5,
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '제목',
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.orange,
                )),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                )),
          ),
        ),
      ],
    );
  }
}
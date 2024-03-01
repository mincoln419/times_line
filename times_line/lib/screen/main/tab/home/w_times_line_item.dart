import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:times_line/common/cli_common.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/entity/post/vo_simple_product_post.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:times_line/entity/todo_task/vo_todo_task.dart';

class TimesLineItem extends StatelessWidget {
  final TodoTask todoTask;
  final TodoTask doneTask;


  const TimesLineItem(this.todoTask, this.doneTask, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Tap(
      onTap: () {
        //this._router.go("/");
        context.go("/productPost/${todoTask.id}");
      },
      child: Expanded(
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.08,
                child: todoTask.timeline.text.make(),
              ),
              Container(
                alignment: Alignment.center,
                width: screenWidth * 0.45,
                height: 40,
                color: context.appColors.knowlegeColor,
                child: todoTask.title.text.make(),
              ),
              emptyExpanded,
              Container(
                alignment: Alignment.center,
                width: screenWidth * 0.45,
                height: 40,
                color: context.appColors.knowlegeColor,
                child: doneTask.title.text.make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

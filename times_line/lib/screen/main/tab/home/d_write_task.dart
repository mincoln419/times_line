import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nav/dialog/dialog.dart';
import 'package:times_line/app.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/common/util/app_keyboard_util.dart';
import 'package:times_line/common/widget/rounded_container.dart';
import 'package:times_line/common/widget/scaffold/bottom_dialog_scaffold.dart';
import 'package:times_line/common/widget/w_round_button.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/main/tab/home/vo_write_todo.dart';
class WriteTaskDialog extends DialogWidget<WriteTodoResult> {

  final TodoTask? todoTask;

  WriteTaskDialog({super.key, this.todoTask});

  @override
  DialogState<WriteTaskDialog> createState() => _WriteTaskDialogState();
}

class _WriteTaskDialogState extends DialogState<WriteTaskDialog> with AfterLayoutMixin{

  DateTime _selectedDate = DateTime.now();
  final textEditingController = TextEditingController();

  final node = FocusNode();

  get isEditMode => widget.todoTask != null;

  @override
  void initState() {
    if(isEditMode){
      _selectedDate = widget.todoTask!.createdTime ?? DateTime.now();
      textEditingController.text = widget.todoTask!.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context ) {
    return BottomDialogScaffold(
        body: RoundedContainer(
          color: context.backgroundColor,
          child: Column(
            children: [
              Row(
                children: [
                  (widget.todoTask == null?'한일을 작성해주세요': widget.todoTask!.title).text.bold.make(),
                  spacer,
                ],
              ),
              height20,
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: node,
                      controller: textEditingController,
                    ),
                  ),
                  RoundButton(
                      text: isEditMode? "수정":"추가",
                      onTap: () {
                        GoRouter.of(context).pop(WriteTodoResult(DateTime.now(), textEditingController.text));
                      }),
                ],
              )
            ],
          ),
        ));;
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    AppKeyboardUtil.show(context, node);
  }
}

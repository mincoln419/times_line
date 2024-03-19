import 'package:times_line/common/cli_common.dart';
import 'package:times_line/data/network/result/api_error.dart';
import 'package:times_line/data/simple_result.dart';
import 'package:times_line/entity/todo_task/task_type.dart';
import 'package:times_line/entity/todo_task/todo_task_status.dart';
import 'package:times_line/entity/todo_task/vo_todo_task.dart';
import 'package:times_line/screen/notification/vo/notification_dummy.dart';
import 'package:times_line/screen/notification/vo/vo_notification.dart';

class TaskApi {
  static Future<SimpleResult<List<DangnNotification>, ApiError>>
      getNotification() async {
    await sleepAsync(300.ms);
    return SimpleResult.success(notificationList);
  }

  static Future<TodoTask> getPost(int id) async {
    await sleepAsync(100.ms);
    return TodoTask(id: id, timeline: 1, createdTime: DateTime.now(), title: '', taskType: TaskType.etc);
  }
}

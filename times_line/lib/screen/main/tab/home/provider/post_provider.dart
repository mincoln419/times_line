import 'package:times_line/data/post_dummy.dart';
import 'package:times_line/entity/post/vo_simple_product_post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postProvider = StateProvider<List<SimpleProductPost>>(
  (ref) => postList,
);

import 'package:times_line/data/network/dangn_api.dart';
import 'package:times_line/entity/post/vo_product_post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productPostProvider = AutoDisposeFutureProviderFamily<ProductPost, int>((ref, id) async {
  return await DangnApi.getPost(id);
});
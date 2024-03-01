import 'package:times_line/entity/post/vo_simple_product_post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vo_product_post.freezed.dart';

@freezed
class ProductPost with _$ProductPost {
  const factory ProductPost({
    required SimpleProductPost simpleProductPost,
    required String content,
}

      ) = _ProductPost;
}

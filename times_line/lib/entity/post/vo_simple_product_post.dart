import 'package:times_line/entity/product/vo_product.dart';
import 'package:times_line/entity/user/vo_address.dart';
import 'package:times_line/entity/user/vo_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vo_simple_product_post.freezed.dart';

@freezed
class SimpleProductPost with _$SimpleProductPost {
  const factory SimpleProductPost(
    final int id,
      final User user,
    final Product product,
    final String title,
    final String description,
    final Address address,
    final int chatCount,
    final int likeCount,
      final DateTime createdTime,
  ) = _ProductPost;
}

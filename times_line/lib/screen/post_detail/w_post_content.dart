import 'package:times_line/common/common.dart';
import 'package:times_line/entity/post/vo_product_post.dart';
import 'package:times_line/entity/post/vo_simple_product_post.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostContentWidget extends StatelessWidget {
  final SimpleProductPost simpleProductPost;
  final ProductPost? productPost;

  const PostContentWidget(
      {super.key, required this.simpleProductPost, this.productPost});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: '${simpleProductPost.id}_title',
          child: Material(
            child: simpleProductPost.title.text.bold.make(),
          ),
        ),
        height20,
        timeago
            .format(simpleProductPost.createdTime,
                locale: context.locale.languageCode)
            .text
            .size(13)
            .color(context.appColors.lessImportant)
            .make(),
        if (productPost == null)
          Center(
            child: CircularProgressIndicator(),
          )
        else
          productPost!.content.text.make().pOnly(top: 30, bottom: 60),
      ],
    ).pSymmetric(v: 15, h: 15);
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:times_line/common/common.dart';
import 'package:times_line/entity/post/vo_simple_product_post.dart';
import 'package:times_line/screen/post_detail/s_post_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nav/enum/enum_nav_ani.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProductPostItem extends StatelessWidget {
  final SimpleProductPost post;

  const ProductPostItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: () {
        //this._router.go("/");
        context.go("/productPost/${post.id}");
      },
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                  tag: '${post.id}_${post.product.images[0]}',
                  child: CachedNetworkImage(
                    imageUrl: post.product.images[0],
                    width: 150,
                  ),
                ),
              ),
              const Width(10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: '${post.id}_title',
                    child:
                        Material(child: post.title.text.size(17).bold.make()),
                  ),
                  Row(
                    children: [
                      post.address.shortAddress.text
                          .color(context.appColors.lessImportantColor)
                          .make(),
                      '•'.text.make(),
                      timeago
                          .format(post.createdTime,
                              locale: context.locale.languageCode)
                          .text
                          .make(),
                    ],
                  ),
                  post.product.price.toMon().text.bold.make(),
                ],
              ))
            ],
          ).p(15),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('$basePath/home/post_comment.png'),
                  post.chatCount.text.make(),
                  Image.asset('$basePath/home/post_heart_off.png'),
                  post.likeCount.text.make(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

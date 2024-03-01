import 'package:times_line/data/user_dummy.dart';
import 'package:times_line/entity/product/product_status.dart';

import '../entity/product/vo_product.dart';

final product1 =
    Product(user1, "아이폰13", 1200000,  ProductStatus.normal, [picSum(300), picSum(400)]);
final product2 =
    Product(user1, "맥북프로M3", 2120000, ProductStatus.booked, [picSum(500), picSum(600)]);
final product3 =
    Product(user2, "아이리버MP3", 35000, ProductStatus.complete, [picSum(700), picSum(550)]);
final product4 =
    Product(user3, "Lucene In Action", 20000 , ProductStatus.booked,[picSum(400), picSum(222)]);

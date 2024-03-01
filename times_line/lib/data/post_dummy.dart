import 'dart:math';

import 'package:times_line/data/user_dummy.dart';
import 'package:times_line/entity/post/vo_simple_product_post.dart';
import 'package:times_line/data/product_dummy.dart';
import 'package:times_line/entity/user/vo_address.dart';

DateTime generateCreateDtm() {
  return DateTime.now().subtract(Duration(minutes: Random().nextInt(1000)));
}

final SimpleProductPost post1 = SimpleProductPost(
  1,
  user1,
  product1,
  "너무너무 좋아요",
  "최신형아이폰입니다",
  const Address("상일동 푸르지오 3층", "상일동"),
  13,
  4,
  generateCreateDtm(),
);

final SimpleProductPost post2 = SimpleProductPost(
  2,
  user2,
  product2,
  "너무 좋아요",
  "최신형맥북입니다",
  const Address("서울특별시 역삼동 구글 한국지사 12층", "역삼동"),
  1,
  23,
  generateCreateDtm(),
);

final SimpleProductPost post3 = SimpleProductPost(
  3,
  user3,
  product3,
  "춘식이 좋아요",
  "옛날 감성의 mp3 플레이어 입니다.",
  const Address("서울특별시 잠실 롯데월드 자이로스윙", "잠실"),
  3,
  15,
  generateCreateDtm(),
);

final SimpleProductPost post4 = SimpleProductPost(
  4,
  user3,
  product4,
  "메롱이다 뫄",
  "검색엔진 공부하기 좋은 책 추천입니다.",
  const Address("서울특별시 홍제동 무악청구아파트 110동 1410호", "홍제동"),
  2,
  1,
  generateCreateDtm(),
);

final postList = [
  post1,
  post2,
  post3,
  post4,
];

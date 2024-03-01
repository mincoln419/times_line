import '../entity/user/vo_user.dart';

String picSum(int id){
  return 'https://picsum.photos/id/$id/200/200';
}


final user1 = User(
  id: 1,
  nickName: 'mermer',
  temperature: 36.5,
  profileUrl: picSum(200),
);

final user2 = User(
  id: 1,
  nickName: 'Rachel',
  temperature: 40.3,
  profileUrl: picSum(1100),
);

final user3 = User(
  id: 1,
  nickName: 'Mike',
  temperature: 31.5,
  profileUrl: picSum(700),
);
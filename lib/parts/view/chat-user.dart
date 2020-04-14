import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_starter_template/util/mock-util.dart';
import 'package:flutter_app_starter_template/util/network-util.dart';

class ChatUser
{
  final int id;
  final String name;
  final String profileImageUrl;
  final String preview;
  final DateTime date;
  final int unreadCount;

  ChatUser({
    @required this.id,
    @required this.name,
    this.profileImageUrl,
    this.preview,
    this.date,
    this.unreadCount,
  });

  static int getMockUserIndexMin()
  {
    return 1;
  }

  static int getMockUserIndexMax()
  {
    return 14;
  }

  /// ログインユーザー（自分）を生成する（IDは0）
  static ChatUser generateMockSelf()
  {
    return ChatUser(
      id:              0,
      name:            Faker().person.name(),
      profileImageUrl: MockUtil.select(threshold: 0.1) ? NetworkUtil.getSampleProfileImageAsUrl(0) : NetworkUtil.getDummyProfileImageAsUrl(),
    );
  }

  /// ユーザーIDを指定してモックユーザーを生成する
  static ChatUser generateMockUser(int userId)
  {
    assert(getMockUserIndexMin() <= userId && userId <= getMockUserIndexMax());

    return ChatUser(
      id:              userId,
      name:            Faker().person.name(),
      profileImageUrl: MockUtil.select(threshold: 0.1) ? NetworkUtil.getSampleProfileImageAsUrl(userId) : NetworkUtil.getDummyProfileImageAsUrl(),
    );
  }

}

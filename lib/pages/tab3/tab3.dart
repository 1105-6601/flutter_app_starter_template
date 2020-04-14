import 'dart:math';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_starter_template/parts/view/chat-detail-view.dart';
import 'package:flutter_app_starter_template/parts/view/chat-user-row.dart';
import 'package:flutter_app_starter_template/parts/view/chat-user.dart';
import 'package:flutter_app_starter_template/util/network-util.dart';
import 'package:flutter_app_starter_template/util/ui-util.dart';
import '../base-tab.dart';

class Tab3 extends BaseTab
{
  final AnimationController animationController;
  final Function(Widget widget) changeTabBody;

  const Tab3({
    Key key,
    this.animationController,
    this.changeTabBody,
  }) : super.list(
    key: key,
    animationController: animationController,
    changeTabBody: changeTabBody,
  );

  @override
  String getTitle()
  {
    return 'Chat App UI';
  }

  @override
  Image resolveIconImage()
  {
    return Image.asset('images/icon-g.png');
  }

  @override
  List<Widget> generateWidgets()
  {
    final listViews = <Widget>[];

    for (int i = ChatUser.getMockUserIndexMin(); i <= ChatUser.getMockUserIndexMax(); i++) {

      final Function select = () {
        return Random().nextDouble() > 0.5;
      };

      final chatUser = ChatUser(
        id:              i,
        profileImageUrl: select() ? NetworkUtil.getSampleProfileImageAsUrl(i) : NetworkUtil.getDummyProfileImageAsUrl(),
        name:            Faker().person.name(),
        preview:         Faker().lorem.sentence(),
        date:            Faker().date.dateTime(minYear: DateTime.now().year - 1, maxYear: DateTime.now().year),
        unreadCount:     Random().nextDouble() > 0.5 ? Faker().randomGenerator.integer(99) : null,
      );

      listViews.add(
        ChatUserRow(
          animation: UiUtil.createAnimation(animationController, 0),
          animationController: animationController,
          chatUser: chatUser,
          onTap: () {
            changeTabBody(ChatDetailView(
              animationController: animationController,
              changeTabBody: changeTabBody,
              chatUser: chatUser,
            ));
          },
        ),
      );
    }

    return listViews;
  }
}
